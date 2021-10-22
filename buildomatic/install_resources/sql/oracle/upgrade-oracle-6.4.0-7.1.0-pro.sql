--
--
-- 6.4.0 to 7.1.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Change column type from "nvarchar2(100)" to "nvarchar2(255)"
ALTER TABLE JIReportJobParameter MODIFY parameter_name nvarchar2(255);

-- Change column type from "nvarchar2(100)" to "nvarchar2(255)"
ALTER TABLE JIReportOptionsInput MODIFY input_name nvarchar2(255);
