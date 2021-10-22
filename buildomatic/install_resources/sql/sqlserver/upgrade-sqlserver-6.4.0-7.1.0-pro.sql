--
--
-- 6.4.0 to 7.1.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Change column type from "nvarchar(100)" to "nvarchar(255)"
ALTER TABLE JIReportJobParameter ALTER COLUMN parameter_name nvarchar(255) NOT NULL;

-- Change column type from "nvarchar(100)" to "nvarchar(255)"
ALTER TABLE JIReportOptionsInput ALTER COLUMN input_name nvarchar(255) NOT NULL;
