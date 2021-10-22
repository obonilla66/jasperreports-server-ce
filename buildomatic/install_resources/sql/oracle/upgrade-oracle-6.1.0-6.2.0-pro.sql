--
--
-- 6.1.0 to 6.2.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Migrate column type from "raw(255)" to "blob"
ALTER TABLE JIListOfValuesItem RENAME COLUMN value TO value_2;
ALTER TABLE JIListOfValuesItem ADD value blob;
UPDATE JIListOfValuesItem SET value=value_2;
ALTER TABLE JIListOfValuesItem DROP (value_2);

-- Create scheduleResource reference to JIResource table
ALTER TABLE JIReportJob ADD scheduledResource number(19,0) DEFAULT 0 NOT NULL;

-- Create temporary job <-> JIResourceTable table
CREATE TABLE temp_job_to_resource AS (
  SELECT
    j.id as job_id, res.id as resource_id
  FROM
    JIReportJob j
  JOIN (
    SELECT
      r.id as id,
      concat(f.uri,concat('/',r.name)) as fulluri
    FROM
      JIResource r JOIN
      JIResourceFolder f ON r.parent_folder = f.id
  ) res ON j.report_unit_uri = res.fulluri
);

-- Update JIReportJob table using temporary table as a mapping
UPDATE
  JIReportJob
SET
  scheduledResource = (
    SELECT
		  resource_id
	  FROM
		  temp_job_to_resource
	  WHERE
		  job_id = id
	);

-- Delete temp table - we do not need it anymore
DROP TABLE temp_job_to_resource;

-- Delete all records and dependencies from JIReportJob for which resources wasn't found
DELETE FROM JIReportJobOutputFormat f WHERE EXISTS (SELECT 1 FROM JIReportJob j WHERE f.report_job_id = j.id AND j.scheduledResource = 0);
DELETE FROM JIReportJobParameter p WHERE EXISTS (SELECT 1 FROM JIReportJob j WHERE p.job_id = j.id AND j.scheduledResource = 0);
DELETE FROM JIReportJob WHERE scheduledResource = 0;

ALTER TABLE JIReportJob
        ADD CONSTRAINT FK156F5F6AFF0F459F
        FOREIGN KEY (scheduledResource)
        REFERENCES JIResource;

-- Change column type from "nvarchar2(250)" to "nvarchar2(1000)"
ALTER TABLE JIObjectPermission MODIFY uri nvarchar2(1000);