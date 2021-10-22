--
--
-- 6.1.0 to 6.2.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Migrate column type from "varchar(255) for bit data" to "blob(20971520)"
ALTER TABLE JIListOfValuesItem ADD COLUMN new_value blob(20971520);
UPDATE JIListOfValuesItem SET new_value = CAST (value AS blob(20971520));
COMMIT;
ALTER TABLE JIListOfValuesItem DROP COLUMN value;
ALTER TABLE JIListOfValuesItem RENAME COLUMN new_value TO value;
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIListOfValuesItem');

-- Create scheduleResource reference to JIResource table
ALTER TABLE JIReportJob ADD COLUMN scheduledResource bigint NOT NULL DEFAULT 0;

-- Create temporary job <-> JIResourceTable table
CREATE TABLE temp_job_to_resource (
	job_id bigint,
	resource_id bigint
);

INSERT INTO temp_job_to_resource (
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

CALL SYSPROC.ADMIN_CMD('REORG TABLE JIReportJobOutputFormat');
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIReportJobParameter');
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIReportJob');

-- Change column type from "varchar(750)" to "varchar(3000)"
ALTER TABLE JIObjectPermission ALTER COLUMN uri SET DATA TYPE varchar(3000);
ALTER TABLE JIObjectPermission ALTER COLUMN uri SET NOT NULL;
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIObjectPermission');