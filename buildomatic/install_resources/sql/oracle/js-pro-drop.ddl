
    drop table JIAccessEvent cascade constraints;

    drop table JIAdhocDataView cascade constraints;

    drop table JIAdhocDataViewBasedReports cascade constraints;

    drop table JIAdhocDataViewInputControl cascade constraints;

    drop table JIAdhocDataViewResource cascade constraints;

    drop table JIAdhocReportUnit cascade constraints;

    drop table JIAdhocState cascade constraints;

    drop table JIAdhocStateProperty cascade constraints;

    drop table JIAuditEvent cascade constraints;

    drop table JIAuditEventArchive cascade constraints;

    drop table JIAuditEventProperty cascade constraints;

    drop table JIAuditEventPropertyArchive cascade constraints;

    drop table JIAwsDatasource cascade constraints;

    drop table JIAzureSqlDatasource cascade constraints;

    drop table JIBeanDatasource cascade constraints;

    drop table JIContentResource cascade constraints;

    drop table JICustomDatasource cascade constraints;

    drop table JICustomDatasourceProperty cascade constraints;

    drop table JICustomDatasourceResource cascade constraints;

    drop table JIDashboardModel cascade constraints;

    drop table JIDashboardModelResource cascade constraints;

    drop table JIDataDefinerUnit cascade constraints;

    drop table JIDataSnapshot cascade constraints;

    drop table JIDataSnapshotContents cascade constraints;

    drop table JIDataSnapshotParameter cascade constraints;

    drop table JIDataType cascade constraints;

    drop table JIDomainDatasource cascade constraints;

    drop table JIDomainDatasourceBundle cascade constraints;

    drop table JIDomainDatasourceDSRef cascade constraints;

    drop table JIFileResource cascade constraints;

    drop table JIFTPInfoProperties cascade constraints;

    drop table JIInputControl cascade constraints;

    drop table JIInputControlQueryColumn cascade constraints;

    drop table JIJdbcDatasource cascade constraints;

    drop table JIJNDIJdbcDatasource cascade constraints;

    drop table JIListOfValues cascade constraints;

    drop table JIListOfValuesItem cascade constraints;

    drop table JILogEvent cascade constraints;

    drop table JIMondrianConnection cascade constraints;

    drop table JIMondrianConnectionGrant cascade constraints;

    drop table JIMondrianXMLADefinition cascade constraints;

    drop table JIObjectPermission cascade constraints;

    drop table JIOlapClientConnection cascade constraints;

    drop table JIOlapUnit cascade constraints;

    drop table JIProfileAttribute cascade constraints;

    drop table JIQuery cascade constraints;

    drop table JIReportAlertToAddress cascade constraints;

    drop table JIReportJob cascade constraints;

    drop table JIReportJobAlert cascade constraints;

    drop table JIReportJobCalendarTrigger cascade constraints;

    drop table JIReportJobMail cascade constraints;

    drop table JIReportJobMailRecipient cascade constraints;

    drop table JIReportJobOutputFormat cascade constraints;

    drop table JIReportJobParameter cascade constraints;

    drop table JIReportJobRepoDest cascade constraints;

    drop table JIReportJobSimpleTrigger cascade constraints;

    drop table JIReportJobTrigger cascade constraints;

    drop table JIReportMonitoringFact cascade constraints;

    drop table JIReportOptions cascade constraints;

    drop table JIReportOptionsInput cascade constraints;

    drop table JIReportThumbnail cascade constraints;

    drop table JIReportUnit cascade constraints;

    drop table JIReportUnitInputControl cascade constraints;

    drop table JIReportUnitResource cascade constraints;

    drop table JIRepositoryCache cascade constraints;

    drop table JIResource cascade constraints;

    drop table JIResourceFolder cascade constraints;

    drop table JIRole cascade constraints;

    drop table JITenant cascade constraints;

    drop table JIUser cascade constraints;

    drop table JIUserRole cascade constraints;

    drop table JIVirtualDatasource cascade constraints;

    drop table JIVirtualDataSourceUriMap cascade constraints;

    drop table JIXMLAConnection cascade constraints;

    drop table ProfilingRecord cascade constraints;

    drop sequence hibernate_sequence;

    DROP INDEX idx24_alert_id_idx ON JIReportAlertToAddress;

    DROP INDEX idx27_destination_id_idx ON JIReportJobMailRecipient;

    DROP INDEX idx14_repodest_id_idx ON JIFTPInfoProperties;

    DROP INDEX idx13_ref_id_idx ON JIDomainDatasourceDSRef;

    DROP INDEX JILogEvent_userId_index ON JILogEvent;

    DROP INDEX JIReportJob_alert_index ON JIReportJob;

    DROP INDEX idx25_content_destination_idx ON JIReportJob;

    DROP INDEX JIReportJob_job_trigger_index ON JIReportJob;

    DROP INDEX idx26_mail_notification_idx ON JIReportJob;

    DROP INDEX JIReportJob_owner_index ON JIReportJob;

    DROP INDEX idx16_mondrianSchema_idx ON JIMondrianConnection;

    DROP INDEX JIInputControl_list_query_idx ON JIInputControl;

    DROP INDEX idx15_input_ctrl_id_idx ON JIInputControlQueryColumn;

    DROP INDEX idx34_item_reference_idx ON JIRepositoryCache;

    DROP INDEX idxA1_resource_id_idx on JICustomDatasourceResource;

    DROP INDEX JIFileResource_reference_index ON JIFileResource;

    DROP INDEX idx35_parent_folder_idx ON JIResourceFolder;

    DROP INDEX JIResourceFolder_version_index ON JIResourceFolder;

    DROP INDEX JIResourceFolder_hidden_index ON JIResourceFolder;

    DROP INDEX JIInputControl_data_type_index ON JIInputControl;

    DROP INDEX JIInputCtrl_list_of_values_idx ON JIInputControl;

    DROP INDEX idx7_audit_event_id_idx ON JIAuditEventProperty;

    DROP INDEX idx8_audit_event_id_idx ON JIAuditEventPropertyArchive;

    DROP INDEX idxA2_resource_id_idx on JIDashboardModelResource;

    DROP INDEX idx20_mondrianConnection_idx ON JIMondrianXMLADefinition;

    DROP INDEX idx18_accessGrant_idx ON JIMondrianConnectionGrant;

    DROP INDEX idx32_report_unit_id_idx ON JIReportUnitResource;

    DROP INDEX JIReportOptions_report_id_idx ON JIReportOptions;

    DROP INDEX idx33_resource_id_idx ON JIReportUnitResource;

    DROP INDEX ProfilingRecord_parent_id_idx ON ProfilingRecord;

    DROP INDEX idx31_report_unit_id_idx ON JIReportUnitInputControl;

    DROP INDEX idx17_reportDataSource_idx ON JIMondrianConnection;

    DROP INDEX idx23_olapClientConnection_idx ON JIOlapUnit;

    DROP INDEX JIQuery_dataSource_index ON JIQuery;

    DROP INDEX idx19_mondrianConnectionId_idx ON JIMondrianConnectionGrant;

    DROP INDEX idx28_resource_id_idx ON JIReportThumbnail;

    DROP INDEX JIReportUnit_mainReport_index ON JIReportUnit;

    DROP INDEX JIReportUnit_query_index ON JIReportUnit;

    DROP INDEX idx29_reportDataSource_idx ON JIReportUnit;

    DROP INDEX idx30_input_ctrl_id_idx ON JIReportUnitInputControl;

    DROP INDEX JIUserRole_userId_index ON JIUserRole;

    DROP INDEX JITenant_parentId_index ON JITenant;

    DROP INDEX idx2_reportDataSource_idx ON JIAdhocDataView;

    DROP INDEX idx3_input_ctrl_id_idx ON JIAdhocDataViewInputControl;

    DROP INDEX JIUser_tenantId_index ON JIUser;

    DROP INDEX idx1_adhocStateId_idx ON JIAdhocDataView;

    DROP INDEX idx12_bundle_id_idx ON JIDomainDatasourceBundle;

    DROP INDEX JIResource_childrenFolder_idx ON JIResource;

    DROP INDEX idx5_adhocStateId_idx ON JIAdhocReportUnit;

    DROP INDEX JIResource_parent_folder_index ON JIResource;

    DROP INDEX idx6_state_id_idx ON JIAdhocStateProperty;

    DROP INDEX idx36_resource_id_idx ON JIVirtualDataSourceUriMap;

    DROP INDEX idx4_resource_id_idx ON JIAdhocDataViewResource;

    DROP INDEX uri_index ON JIObjectPermission;

    DROP INDEX idxA3_report_id_idx on JIAdhocDataViewBasedReports;

    DROP INDEX idx21_recipientobjclass_idx ON JIObjectPermission;

    DROP INDEX idx22_recipientobjid_idx ON JIObjectPermission;

    DROP INDEX JIRole_tenantId_index ON JIRole;

    DROP INDEX JIUserRole_roleId_index ON JIUserRole;
