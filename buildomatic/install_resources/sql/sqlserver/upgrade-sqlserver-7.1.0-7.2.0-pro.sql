--
--
-- 7.1.0 to 7.2.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--

-- Legacy Dashboards Removal
DROP TABLE JIDashboardFrameProperty;
DROP TABLE JIDashboardResource;
DROP TABLE JIDashboard;

DELETE FROM JIObjectPermission
WHERE uri IN (
  SELECT ('repo:' + f.uri + '/' + r.name) AS fulluri
  FROM JIResource r
  JOIN JIResourceFolder f ON r.parent_folder = f.id
  WHERE resourcetype = 'com.jaspersoft.ji.adhoc.DashboardResource'
);

DELETE FROM JIResource WHERE resourcetype = 'com.jaspersoft.ji.adhoc.DashboardResource';

-- Scheduler Upgrade
ALTER TABLE QRTZ_FIRED_TRIGGERS ADD SCHED_TIME BIGINT;
UPDATE QRTZ_FIRED_TRIGGERS SET SCHED_TIME = FIRED_TIME;
ALTER TABLE QRTZ_FIRED_TRIGGERS ALTER COLUMN SCHED_TIME BIGINT NOT NULL;