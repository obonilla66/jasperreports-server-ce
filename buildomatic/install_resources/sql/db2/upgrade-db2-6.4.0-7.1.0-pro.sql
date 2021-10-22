--
--
-- 6.4.0 to 7.1.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Change column type from "varchar(300)" to "varchar(765)"
ALTER TABLE JIReportJobParameter ALTER COLUMN parameter_name SET DATA TYPE varchar(765);
ALTER TABLE JIReportJobParameter ALTER COLUMN parameter_name SET NOT NULL;
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIReportJobParameter');

-- Change column type from "varchar(300)" to "varchar(765)"
ALTER TABLE JIReportOptionsInput ALTER COLUMN input_name SET DATA TYPE varchar(765);
ALTER TABLE JIReportOptionsInput ALTER COLUMN input_name SET NOT NULL;
CALL SYSPROC.ADMIN_CMD('REORG TABLE JIReportOptionsInput');
