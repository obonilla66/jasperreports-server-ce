--
--
-- 6.1.0 to 6.2.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Change column type from "varbinary(255)" to "varbinary(max)"
ALTER TABLE JIListOfValuesItem ALTER COLUMN value varbinary(max) NULL;

-- Create scheduleResource reference to JIResource table
ALTER TABLE JIReportJob ADD scheduledResource numeric(19,0) NOT NULL DEFAULT(0);

-- Create temporary job <-> JIResourceTable table
CREATE TABLE temp_job_to_resource (
  job_id numeric(19,0),
	resource_id numeric(19,0)
);

INSERT INTO
  temp_job_to_resource
SELECT
  j.id as job_id, res.id as resource_id
FROM
  JIReportJob j
JOIN (
  SELECT
    r.id as id,
    (f.uri + '/' + r.name) as fulluri
  FROM
    JIResource r JOIN
    JIResourceFolder f ON r.parent_folder = f.id
) res ON j.report_unit_uri = res.fulluri

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
DELETE f FROM JIReportJobOutputFormat f INNER JOIN JIReportJob j ON f.report_job_id = j.id WHERE j.scheduledResource = 0;
DELETE p FROM JIReportJobParameter p INNER JOIN JIReportJob j ON p.job_id = j.id WHERE j.scheduledResource = 0;
DELETE FROM JIReportJob WHERE scheduledResource = 0;

ALTER TABLE JIReportJob
        ADD CONSTRAINT FK156F5F6AFF0F459F
        FOREIGN KEY (scheduledResource)
        REFERENCES JIResource;

-- Change column type from "nvarchar(250)" to "nvarchar(1000)"
ALTER TABLE JIObjectPermission ALTER COLUMN uri nvarchar(1000) NOT NULL;
