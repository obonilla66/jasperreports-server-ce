
    drop table JIAccessEvent;

    drop table JIAdhocDataView;

    drop table JIAdhocDataViewBasedReports;

    drop table JIAdhocDataViewInputControl;

    drop table JIAdhocDataViewResource;

    drop table JIAdhocReportUnit;

    drop table JIAdhocState;

    drop table JIAdhocStateProperty;

    drop table JIAuditEvent;

    drop table JIAuditEventArchive;

    drop table JIAuditEventProperty;

    drop table JIAuditEventPropertyArchive;

    drop table JIAwsDatasource;

    drop table JIAzureSqlDatasource;

    drop table JIBeanDatasource;

    drop table JIContentResource;

    drop table JICustomDatasource;

    drop table JICustomDatasourceProperty;

    drop table JICustomDatasourceResource;

    drop table JIDashboardModel;

    drop table JIDashboardModelResource;

    drop table JIDataDefinerUnit;

    drop table JIDataSnapshot;

    drop table JIDataSnapshotContents;

    drop table JIDataSnapshotParameter;

    drop table JIDataType;

    drop table JIDomainDatasource;

    drop table JIDomainDatasourceBundle;

    drop table JIDomainDatasourceDSRef;

    drop table JIFileResource;

    drop table JIFTPInfoProperties;

    drop table JIInputControl;

    drop table JIInputControlQueryColumn;

    drop table JIJdbcDatasource;

    drop table JIJNDIJdbcDatasource;

    drop table JIListOfValues;

    drop table JIListOfValuesItem;

    drop table JILogEvent;

    drop table JIMondrianConnection;

    drop table JIMondrianConnectionGrant;

    drop table JIMondrianXMLADefinition;

    drop table JIObjectPermission;

    drop table JIOlapClientConnection;

    drop table JIOlapUnit;

    drop table JIProfileAttribute;

    drop table JIQuery;

    drop table JIReportAlertToAddress;

    drop table JIReportJob;

    drop table JIReportJobAlert;

    drop table JIReportJobCalendarTrigger;

    drop table JIReportJobMail;

    drop table JIReportJobMailRecipient;

    drop table JIReportJobOutputFormat;

    drop table JIReportJobParameter;

    drop table JIReportJobRepoDest;

    drop table JIReportJobSimpleTrigger;

    drop table JIReportJobTrigger;

    drop table JIReportMonitoringFact;

    drop table JIReportOptions;

    drop table JIReportOptionsInput;

    drop table JIReportThumbnail;

    drop table JIReportUnit;

    drop table JIReportUnitInputControl;

    drop table JIReportUnitResource;

    drop table JIRepositoryCache;

    drop table JIResource;

    drop table JIResourceFolder;

    drop table JIRole;

    drop table JITenant;

    drop table JIUser;

    drop table JIUserRole;

    drop table JIVirtualDatasource;

    drop table JIVirtualDataSourceUriMap;

    drop table JIXMLAConnection;

    drop table ProfilingRecord;

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
