
    create table JIAccessEvent (
       id bigint identity not null,
        user_id bigint not null,
        event_date datetime not null,
        resource_id bigint not null,
        updating bit not null,
        primary key (id)
    );

    create table JIAdhocDataView (
       id bigint not null,
        adhocStateId bigint,
        reportDataSource bigint,
        promptcontrols bit,
        controlslayout smallint,
        controlrenderer nvarchar(100),
        primary key (id)
    );

    create table JIAdhocDataViewBasedReports (
       adhoc_data_view_id bigint not null,
        report_index int not null,
        report_id bigint not null,
        primary key (adhoc_data_view_id, report_index)
    );

    create table JIAdhocDataViewInputControl (
       adhoc_data_view_id bigint not null,
        control_index int not null,
        input_control_id bigint not null,
        primary key (adhoc_data_view_id, control_index)
    );

    create table JIAdhocDataViewResource (
       adhoc_data_view_id bigint not null,
        resource_index int not null,
        resource_id bigint not null,
        primary key (adhoc_data_view_id, resource_index)
    );

    create table JIAdhocReportUnit (
       id bigint not null,
        adhocStateId bigint,
        primary key (id)
    );

    create table JIAdhocState (
       id bigint identity not null,
        type nvarchar(255) not null,
        theme nvarchar(255),
        title nvarchar(255),
        pageOrientation nvarchar(255),
        paperSize nvarchar(255),
        primary key (id)
    );

    create table JIAdhocStateProperty (
       state_id bigint not null,
        name nvarchar(100) not null,
        value nvarchar(1000),
        primary key (state_id, name)
    );

    create table JIAuditEvent (
       id bigint identity not null,
        username nvarchar(100),
        tenant_id nvarchar(100),
        event_date datetime not null,
        resource_uri nvarchar(250),
        resource_type nvarchar(250),
        event_type nvarchar(100) not null,
        request_type nvarchar(100) not null,
        primary key (id)
    );

    create table JIAuditEventArchive (
       id bigint identity not null,
        username nvarchar(100),
        tenant_id nvarchar(100),
        event_date datetime not null,
        resource_uri nvarchar(250),
        resource_type nvarchar(250),
        event_type nvarchar(100) not null,
        request_type nvarchar(100) not null,
        primary key (id)
    );

    create table JIAuditEventProperty (
       id bigint identity not null,
        property_type nvarchar(100) not null,
        value nvarchar(250),
        clob_value nvarchar(MAX),
        audit_event_id bigint not null,
        primary key (id)
    );

    create table JIAuditEventPropertyArchive (
       id bigint identity not null,
        property_type nvarchar(100) not null,
        value nvarchar(250),
        clob_value nvarchar(MAX),
        audit_event_id bigint not null,
        primary key (id)
    );

    create table JIAwsDatasource (
       id bigint not null,
        accessKey nvarchar(150),
        secretKey nvarchar(255),
        roleARN nvarchar(100),
        region nvarchar(100) not null,
        dbName nvarchar(100) not null,
        dbInstanceIdentifier nvarchar(100) not null,
        dbService nvarchar(100) not null,
        primary key (id)
    );

    create table JIAzureSqlDatasource (
       id bigint not null,
        keyStore_id bigint not null,
        keyStorePassword nvarchar(100),
        keyStoreType nvarchar(25),
        subscriptionId nvarchar(100),
        serverName nvarchar(100) not null,
        dbName nvarchar(100) not null,
        primary key (id)
    );

    create table JIBeanDatasource (
       id bigint not null,
        beanName nvarchar(100) not null,
        beanMethod nvarchar(100),
        primary key (id)
    );

    create table JIContentResource (
       id bigint not null,
        data varbinary(max),
        file_type nvarchar(20),
        primary key (id)
    );

    create table JICustomDatasource (
       id bigint not null,
        serviceClass nvarchar(250) not null,
        primary key (id)
    );

    create table JICustomDatasourceProperty (
       ds_id bigint not null,
        name nvarchar(200) not null,
        value nvarchar(1000),
        primary key (ds_id, name)
    );

    create table JICustomDatasourceResource (
       ds_id bigint not null,
        name nvarchar(200) not null,
        resource_id bigint not null,
        primary key (ds_id, name)
    );

    create table JIDashboardModel (
       id bigint not null,
        foundationsString nvarchar(MAX),
        resourcesString nvarchar(MAX),
        defaultFoundation int,
        primary key (id)
    );

    create table JIDashboardModelResource (
       dashboard_id bigint not null,
        resource_index int not null,
        resource_id bigint not null,
        primary key (dashboard_id, resource_index)
    );

    create table JIDataDefinerUnit (
       id bigint not null,
        primary key (id)
    );

    create table JIDataSnapshot (
       id bigint identity not null,
        version int not null,
        snapshot_date datetime,
        contents_id bigint not null,
        primary key (id)
    );

    create table JIDataSnapshotContents (
       id bigint identity not null,
        data varbinary(max) not null,
        primary key (id)
    );

    create table JIDataSnapshotParameter (
       id bigint not null,
        parameter_name nvarchar(100) not null,
        parameter_value varbinary(max),
        primary key (id, parameter_name)
    );

    create table JIDataType (
       id bigint not null,
        type smallint,
        maxLength int,
        decimals int,
        regularExpr nvarchar(255),
        minValue varbinary(1000),
        max_value varbinary(1000),
        strictMin bit,
        strictMax bit,
        primary key (id)
    );

    create table JIDomainDatasource (
       id bigint not null,
        schema_id bigint not null,
        security_id bigint,
        primary key (id)
    );

    create table JIDomainDatasourceBundle (
       slds_id bigint not null,
        idx int not null,
        locale nvarchar(20),
        bundle_id bigint not null,
        primary key (slds_id, idx)
    );

    create table JIDomainDatasourceDSRef (
       slds_id bigint not null,
        alias nvarchar(200) not null,
        ref_id bigint not null,
        primary key (slds_id, alias)
    );

    create table JIFileResource (
       id bigint not null,
        data varbinary(max),
        file_type nvarchar(20),
        reference bigint,
        primary key (id)
    );

    create table JIFTPInfoProperties (
       repodest_id bigint not null,
        property_name nvarchar(100) not null,
        property_value nvarchar(250),
        primary key (repodest_id, property_name)
    );

    create table JIInputControl (
       id bigint not null,
        type smallint,
        mandatory bit,
        readOnly bit,
        visible bit,
        data_type bigint,
        list_of_values bigint,
        list_query bigint,
        query_value_column nvarchar(200),
        defaultValue varbinary(255),
        primary key (id)
    );

    create table JIInputControlQueryColumn (
       input_control_id bigint not null,
        column_index int not null,
        query_column nvarchar(200) not null,
        primary key (input_control_id, column_index)
    );

    create table JIJdbcDatasource (
       id bigint not null,
        driver nvarchar(100) not null,
        password nvarchar(250),
        connectionUrl nvarchar(500),
        username nvarchar(100),
        timezone nvarchar(100),
        primary key (id)
    );

    create table JIJNDIJdbcDatasource (
       id bigint not null,
        jndiName nvarchar(100) not null,
        timezone nvarchar(100),
        primary key (id)
    );

    create table JIListOfValues (
       id bigint not null,
        primary key (id)
    );

    create table JIListOfValuesItem (
       id bigint not null,
        idx int not null,
        label nvarchar(255),
        value varbinary(max),
        primary key (id, idx)
    );

    create table JILogEvent (
       id bigint identity not null,
        occurrence_date datetime not null,
        event_type smallint not null,
        component nvarchar(100),
        message nvarchar(250) not null,
        resource_uri nvarchar(250),
        event_text nvarchar(MAX),
        event_data varbinary(max),
        event_state smallint,
        userId bigint,
        primary key (id)
    );

    create table JIMondrianConnection (
       id bigint not null,
        reportDataSource bigint,
        mondrianSchema bigint,
        primary key (id)
    );

    create table JIMondrianConnectionGrant (
       mondrianConnectionId bigint not null,
        grantIndex int not null,
        accessGrant bigint not null,
        primary key (mondrianConnectionId, grantIndex)
    );

    create table JIMondrianXMLADefinition (
       id bigint not null,
        catalog nvarchar(100) not null,
        mondrianConnection bigint,
        primary key (id)
    );

    create table JIObjectPermission (
       id bigint identity not null,
        uri nvarchar(1000) not null,
        recipientobjectclass nvarchar(250),
        recipientobjectid bigint,
        permissionMask int not null,
        primary key (id)
    );

    create table JIOlapClientConnection (
       id bigint not null,
        primary key (id)
    );

    create table JIOlapUnit (
       id bigint not null,
        olapClientConnection bigint,
        mdx_query nvarchar(MAX) not null,
        view_options varbinary(max),
        primary key (id)
    );

    create table JIProfileAttribute (
       id bigint identity not null,
        attrName nvarchar(255) not null,
        attrValue nvarchar(2000),
        description nvarchar(255),
        owner nvarchar(255),
        principalobjectclass nvarchar(255) not null,
        principalobjectid bigint not null,
        primary key (id)
    );

    create table JIQuery (
       id bigint not null,
        dataSource bigint,
        query_language nvarchar(40) not null,
        sql_query nvarchar(MAX) not null,
        primary key (id)
    );

    create table JIReportAlertToAddress (
       alert_id bigint not null,
        to_address_idx int not null,
        to_address nvarchar(100) not null,
        primary key (alert_id, to_address_idx)
    );

    create table JIReportJob (
       id bigint identity not null,
        version int not null,
        owner bigint not null,
        label nvarchar(100) not null,
        description nvarchar(2000),
        creation_date datetime,
        report_unit_uri nvarchar(250) not null,
        scheduledResource bigint not null,
        job_trigger bigint not null,
        base_output_name nvarchar(100) not null,
        output_locale nvarchar(20),
        content_destination bigint,
        mail_notification bigint,
        alert bigint,
        primary key (id)
    );

    create table JIReportJobAlert (
       id bigint identity not null,
        version int not null,
        recipient smallint not null,
        subject nvarchar(100),
        message_text nvarchar(2000),
        message_text_when_job_fails nvarchar(2000),
        job_state smallint not null,
        including_stack_trace bit not null,
        including_report_job_info bit not null,
        primary key (id)
    );

    create table JIReportJobCalendarTrigger (
       id bigint not null,
        minutes nvarchar(200) not null,
        hours nvarchar(80) not null,
        days_type smallint not null,
        week_days nvarchar(20),
        month_days nvarchar(100),
        months nvarchar(40) not null,
        primary key (id)
    );

    create table JIReportJobMail (
       id bigint identity not null,
        version int not null,
        subject nvarchar(100) not null,
        message nvarchar(2000),
        send_type smallint not null,
        skip_empty bit not null,
        message_text_when_job_fails nvarchar(2000),
        inc_stktrc_when_job_fails bit not null,
        skip_notif_when_job_fails bit not null,
        primary key (id)
    );

    create table JIReportJobMailRecipient (
       destination_id bigint not null,
        recipient_idx int not null,
        recipient_type smallint not null,
        address nvarchar(100) not null,
        primary key (destination_id, recipient_idx)
    );

    create table JIReportJobOutputFormat (
       report_job_id bigint not null,
        output_format smallint not null,
        primary key (report_job_id, output_format)
    );

    create table JIReportJobParameter (
       job_id bigint not null,
        parameter_name nvarchar(255) not null,
        parameter_value varbinary(max),
        primary key (job_id, parameter_name)
    );

    create table JIReportJobRepoDest (
       id bigint identity not null,
        version int not null,
        folder_uri nvarchar(250),
        sequential_filenames bit not null,
        overwrite_files bit not null,
        save_to_repository bit not null,
        output_description nvarchar(250),
        timestamp_pattern nvarchar(250),
        using_def_rpt_opt_folder_uri bit not null,
        output_local_folder nvarchar(250),
        user_name nvarchar(50),
        password nvarchar(250),
        server_name nvarchar(150),
        folder_path nvarchar(250),
        ssh_private_key bigint,
        primary key (id)
    );

    create table JIReportJobSimpleTrigger (
       id bigint not null,
        occurrence_count int not null,
        recurrence_interval int,
        recurrence_interval_unit smallint,
        primary key (id)
    );

    create table JIReportJobTrigger (
       id bigint identity not null,
        version int not null,
        timezone nvarchar(40),
        start_type smallint not null,
        start_date datetime,
        end_date datetime,
        calendar_name nvarchar(50),
        misfire_instruction int not null,
        primary key (id)
    );

    create table JIReportMonitoringFact (
       id bigint identity not null,
        date_year smallint not null,
        date_month smallint not null,
        date_day smallint not null,
        time_hour smallint not null,
        time_minute smallint not null,
        event_context nvarchar(255) not null,
        user_organization nvarchar(255),
        user_name nvarchar(255),
        event_type nvarchar(255) not null,
        report_uri nvarchar(255),
        editing_action nvarchar(255),
        query_execution_time int not null,
        report_rendering_time int not null,
        total_report_execution_time int not null,
        time_stamp datetime not null,
        primary key (id)
    );

    create table JIReportOptions (
       id bigint not null,
        options_name nvarchar(210) not null,
        report_id bigint not null,
        primary key (id)
    );

    create table JIReportOptionsInput (
       options_id bigint not null,
        input_name nvarchar(255) not null,
        input_value varbinary(max),
        primary key (options_id, input_name)
    );

    create table JIReportThumbnail (
       id bigint identity not null,
        user_id bigint not null,
        resource_id bigint not null,
        thumbnail varbinary(max) not null,
        primary key (id)
    );

    create table JIReportUnit (
       id bigint not null,
        reportDataSource bigint,
        query bigint,
        mainReport bigint,
        controlrenderer nvarchar(100),
        reportrenderer nvarchar(100),
        promptcontrols bit,
        controlslayout smallint,
        data_snapshot_id bigint,
        primary key (id)
    );

    create table JIReportUnitInputControl (
       report_unit_id bigint not null,
        control_index int not null,
        input_control_id bigint not null,
        primary key (report_unit_id, control_index)
    );

    create table JIReportUnitResource (
       report_unit_id bigint not null,
        resource_index int not null,
        resource_id bigint not null,
        primary key (report_unit_id, resource_index)
    );

    create table JIRepositoryCache (
       id bigint identity not null,
        uri nvarchar(250) not null,
        cache_name nvarchar(20) not null,
        data varbinary(max),
        version int not null,
        version_date datetime not null,
        item_reference bigint,
        primary key (id)
    );

    create table JIResource (
       id bigint identity not null,
        version int not null,
        name nvarchar(200) not null,
        parent_folder bigint not null,
        childrenFolder bigint,
        label nvarchar(200) not null,
        description nvarchar(250),
        resourceType nvarchar(255) not null,
        creation_date datetime not null,
        update_date datetime not null,
        primary key (id)
    );

    create table JIResourceFolder (
       id bigint identity not null,
        version int not null,
        uri nvarchar(250) not null,
        hidden bit,
        name nvarchar(200) not null,
        label nvarchar(200) not null,
        description nvarchar(250),
        parent_folder bigint,
        creation_date datetime not null,
        update_date datetime not null,
        primary key (id)
    );

    create table JIRole (
       id bigint identity not null,
        rolename nvarchar(100) not null,
        tenantId bigint not null,
        externallyDefined bit,
        primary key (id)
    );

    create table JITenant (
       id bigint identity not null,
        tenantId nvarchar(100) not null,
        tenantAlias nvarchar(100) not null,
        parentId bigint,
        tenantName nvarchar(100) not null,
        tenantDesc nvarchar(250),
        tenantNote nvarchar(250),
        tenantUri nvarchar(250) not null,
        tenantFolderUri nvarchar(250) not null,
        theme nvarchar(250),
        primary key (id)
    );

    create table JIUser (
       id bigint identity not null,
        username nvarchar(100) not null,
        tenantId bigint not null,
        fullname nvarchar(100) not null,
        emailAddress nvarchar(100),
        password nvarchar(250),
        externallyDefined bit,
        enabled bit,
        previousPasswordChangeTime datetime,
        primary key (id)
    );

    create table JIUserRole (
       roleId bigint not null,
        userId bigint not null,
        primary key (userId, roleId)
    );

    create table JIVirtualDatasource (
       id bigint not null,
        timezone nvarchar(100),
        primary key (id)
    );

    create table JIVirtualDataSourceUriMap (
       virtualDS_id bigint not null,
        data_source_name nvarchar(200) not null,
        resource_id bigint not null,
        primary key (virtualDS_id, data_source_name)
    );

    create table JIXMLAConnection (
       id bigint not null,
        catalog nvarchar(100) not null,
        username nvarchar(100) not null,
        password nvarchar(250) not null,
        datasource nvarchar(100) not null,
        uri nvarchar(100) not null,
        primary key (id)
    );

    create table ProfilingRecord (
       id bigint identity not null,
        parent_id bigint,
        duration_ms bigint,
        description nvarchar(1000),
        begin_date datetime not null,
        cache_hit bit,
        agg_hit bit,
        sql_query bit,
        mdx_query bit,
        begin_year int not null,
        begin_month int not null,
        begin_day int not null,
        begin_hour int not null,
        begin_min int not null,
        begin_sec int not null,
        begin_ms int not null,
        primary key (id)
    );
create index access_user_index on JIAccessEvent (user_id);
create index access_date_index on JIAccessEvent (event_date);
create index access_res_index on JIAccessEvent (resource_id);
create index access_upd_index on JIAccessEvent (updating);
create index username_index on JIAuditEvent (username);
create index tenant_id_index on JIAuditEvent (tenant_id);
create index event_date_index on JIAuditEvent (event_date);
create index resource_uri_index on JIAuditEvent (resource_uri);
create index res_type_index on JIAuditEvent (resource_type);
create index event_type_index on JIAuditEvent (event_type);
create index request_type_index on JIAuditEvent (request_type);
create index date_year_index on JIReportMonitoringFact (date_year);
create index date_month_index on JIReportMonitoringFact (date_month);
create index date_day_index on JIReportMonitoringFact (date_day);
create index time_hour_index on JIReportMonitoringFact (time_hour);
create index time_minute_index on JIReportMonitoringFact (time_minute);
create index event_context_index on JIReportMonitoringFact (event_context);
create index user_organization_index on JIReportMonitoringFact (user_organization);
create index user_name_index on JIReportMonitoringFact (user_name);
create index event_type_index_2 on JIReportMonitoringFact (event_type);
create index report_uri_index on JIReportMonitoringFact (report_uri);
create index editing_action_index on JIReportMonitoringFact (editing_action);
create index query_execution_time_index on JIReportMonitoringFact (query_execution_time);
create index report_rendering_time_index on JIReportMonitoringFact (report_rendering_time);
create index total_report_exec_time_index on JIReportMonitoringFact (total_report_execution_time);
create index time_stamp_index on JIReportMonitoringFact (time_stamp);

    alter table JIReportThumbnail 
       add constraint UKby8mikd2bdxyvgguosocs0yn3 unique (user_id, resource_id);

    alter table JIRepositoryCache 
       add constraint UKt25kjcmwyu0v0jvmgj7jpe7fq unique (uri, cache_name);
create index resource_type_index on JIResource (resourceType);

    alter table JIResource 
       add constraint UKq0fsg83g1w6207k40fixjobra unique (name, parent_folder);

    alter table JIResourceFolder 
       add constraint UK_emu9w2irh08lh7kw07be7u1vp unique (uri);

    alter table JIRole 
       add constraint UKqrupjb1yd43e3t6po2nk038t9 unique (rolename, tenantId);

    alter table JITenant 
       add constraint UK1jv9e2tsi2vn74xivgia15g42 unique (tenantId);

    alter table JIUser 
       add constraint UKrw3wi1dqcub2iiom9pvdtuso unique (username, tenantId);

    alter table JIAccessEvent 
       add constraint FK7caj87u72rymu6805gtek03y8 
       foreign key (user_id) 
       references JIUser;

    alter table JIAccessEvent 
       add constraint FK8lqavxfshc29dnw97io0t6wbf 
       foreign key (resource_id) 
       references JIResource 
       on delete cascade;

    alter table JIAdhocDataView 
       add constraint FKg7peg7nx3m94onnjkuluvtl3o 
       foreign key (id) 
       references JIResource;

    alter table JIAdhocDataView 
       add constraint FKmuqa9b9jrsee17jfw6pppm1ho 
       foreign key (adhocStateId) 
       references JIAdhocState;

    alter table JIAdhocDataView 
       add constraint FKjyeqt92gxl0dxoa5lkf75yiwi 
       foreign key (reportDataSource) 
       references JIResource;

    alter table JIAdhocDataViewBasedReports 
       add constraint FKpk0usonjjc7np9td0hv6j7deu 
       foreign key (report_id) 
       references JIReportUnit;

    alter table JIAdhocDataViewBasedReports 
       add constraint FK4l78a5g4kembkvorbymim9ng1 
       foreign key (adhoc_data_view_id) 
       references JIAdhocDataView;

    alter table JIAdhocDataViewInputControl 
       add constraint FKc6ue8x1g6fltqk5ke6inm3mml 
       foreign key (input_control_id) 
       references JIInputControl;

    alter table JIAdhocDataViewInputControl 
       add constraint FKkiv278kuwgfvkbq3jcodp1hy0 
       foreign key (adhoc_data_view_id) 
       references JIAdhocDataView;

    alter table JIAdhocDataViewResource 
       add constraint FK5pk4arpyfu6671xfecq51968c 
       foreign key (resource_id) 
       references JIFileResource;

    alter table JIAdhocDataViewResource 
       add constraint FK5qctuwjt04urra07jvsxpli1x 
       foreign key (adhoc_data_view_id) 
       references JIAdhocDataView;

    alter table JIAdhocReportUnit 
       add constraint FKdqcwil8gqy3qgh9cr4dx3p1no 
       foreign key (id) 
       references JIReportUnit;

    alter table JIAdhocReportUnit 
       add constraint FKom4d2gy6ixe28dlwsbb4on7wt 
       foreign key (adhocStateId) 
       references JIAdhocState;

    alter table JIAdhocStateProperty 
       add constraint FKcc6y167w7n3u3ketxtmlwpsqr 
       foreign key (state_id) 
       references JIAdhocState;

    alter table JIAuditEventProperty 
       add constraint FK74sb8dic688mlyencffek40iw 
       foreign key (audit_event_id) 
       references JIAuditEvent;

    alter table JIAuditEventPropertyArchive 
       add constraint FK1lo2yra6fdwxqxo9769vyf4to 
       foreign key (audit_event_id) 
       references JIAuditEventArchive;

    alter table JIAwsDatasource 
       add constraint FKa2q6ho769d4h6k1inqfw0avbi 
       foreign key (id) 
       references JIJdbcDatasource;

    alter table JIAzureSqlDatasource 
       add constraint FKq54ak99008wuueewun6lw3x8p 
       foreign key (id) 
       references JIJdbcDatasource;

    alter table JIAzureSqlDatasource 
       add constraint FK88n34smbe9i5eiqyvts12427n 
       foreign key (keyStore_id) 
       references JIResource;

    alter table JIBeanDatasource 
       add constraint FKcq7pt3wmr5oua2omyaynj18wm 
       foreign key (id) 
       references JIResource;

    alter table JIContentResource 
       add constraint FKc903d1j62d6q2alfowyml1qyc 
       foreign key (id) 
       references JIResource;

    alter table JICustomDatasource 
       add constraint FK698qlo478w8q00ratagvxjigg 
       foreign key (id) 
       references JIResource;

    alter table JICustomDatasourceProperty 
       add constraint FKlmhvtq6f4aj7nbgpkop6pvwaj 
       foreign key (ds_id) 
       references JICustomDatasource;

    alter table JICustomDatasourceResource 
       add constraint FKdqu6gyndmi8barxd4e4mwgiu1 
       foreign key (resource_id) 
       references JIResource;

    alter table JICustomDatasourceResource 
       add constraint FK2b8of47ft9ucqg6wxq51d94f6 
       foreign key (ds_id) 
       references JICustomDatasource;

    alter table JIDashboardModel 
       add constraint FKno3tso0jfqti1hhbl8c25n0ry 
       foreign key (id) 
       references JIResource;

    alter table JIDashboardModelResource 
       add constraint FKay6k91x53147ricaco1bkq0n7 
       foreign key (resource_id) 
       references JIResource;

    alter table JIDashboardModelResource 
       add constraint FKlf6l6i2usj0a8dglfr86c73c7 
       foreign key (dashboard_id) 
       references JIDashboardModel;

    alter table JIDataDefinerUnit 
       add constraint FKh06lfl9tq7r7kufnt5xifgef4 
       foreign key (id) 
       references JIReportUnit;

    alter table JIDataSnapshotParameter 
       add constraint id_fk_idx 
       foreign key (id) 
       references JIDataSnapshot;

    alter table JIDataType 
       add constraint FKfowvvrdpyr4fsfdt0qekb6b31 
       foreign key (id) 
       references JIResource;

    alter table JIDomainDatasource 
       add constraint FKa9yl52eu0t0gtdnhv92hw9ndi 
       foreign key (id) 
       references JIResource;

    alter table JIDomainDatasource 
       add constraint FK5lm14amynuir6h7uc7dfx05t7 
       foreign key (schema_id) 
       references JIFileResource;

    alter table JIDomainDatasource 
       add constraint FK7bsk45qyalthk4lrcv4mxwa05 
       foreign key (security_id) 
       references JIFileResource;

    alter table JIDomainDatasourceBundle 
       add constraint FKlr5ldt3fi8d9x6s1ey8xcctje 
       foreign key (slds_id) 
       references JIDomainDatasource;

    alter table JIDomainDatasourceBundle 
       add constraint FKtr8knmhxriwomlt8nppn1k50m 
       foreign key (bundle_id) 
       references JIFileResource;

    alter table JIDomainDatasourceDSRef 
       add constraint FKikqlpr2kfty5to5seufum9sep 
       foreign key (ref_id) 
       references JIResource;

    alter table JIDomainDatasourceDSRef 
       add constraint FKt7lysq7v9t62tpu4vdirp50pl 
       foreign key (slds_id) 
       references JIDomainDatasource;

    alter table JIFileResource 
       add constraint FK9cks6rnum2e1nwpltygmric0a 
       foreign key (id) 
       references JIResource;

    alter table JIFileResource 
       add constraint FK7lou06p9h4uewmjilbvtiyfti 
       foreign key (reference) 
       references JIFileResource;

    alter table JIFTPInfoProperties 
       add constraint FKs9ui25pnlkwvymdhafps0eqox 
       foreign key (repodest_id) 
       references JIReportJobRepoDest;

    alter table JIInputControl 
       add constraint FK7gw3h08vhv4ehuscnk22lweb0 
       foreign key (id) 
       references JIResource;

    alter table JIInputControl 
       add constraint FKidpnbmursposu1b72a37j99dg 
       foreign key (data_type) 
       references JIDataType;

    alter table JIInputControl 
       add constraint FK8igl58hkwa8csd2pptsj6sl48 
       foreign key (list_of_values) 
       references JIListOfValues;

    alter table JIInputControl 
       add constraint FKeji041b95gimh1lii27d3j66f 
       foreign key (list_query) 
       references JIQuery;

    alter table JIInputControlQueryColumn 
       add constraint FKawiyltd98xvdsp3syt7fllehw 
       foreign key (input_control_id) 
       references JIInputControl;

    alter table JIJdbcDatasource 
       add constraint FKkjuw9e7bu5n4k5nm3osifg5gc 
       foreign key (id) 
       references JIResource;

    alter table JIJNDIJdbcDatasource 
       add constraint FK2gd8opslbt6erc8yx74s6j0nw 
       foreign key (id) 
       references JIResource;

    alter table JIListOfValues 
       add constraint FKaoih4o3b0gmj4vgvocwb2m9qp 
       foreign key (id) 
       references JIResource;

    alter table JIListOfValuesItem 
       add constraint FK2eq5m33wjtmf3d61gp38aqq77 
       foreign key (id) 
       references JIListOfValues;

    alter table JILogEvent 
       add constraint FK7636lhqn8drpalfckmb5wlljb 
       foreign key (userId) 
       references JIUser;

    alter table JIMondrianConnection 
       add constraint FKm9glomusslw0ouy1xev0kafql 
       foreign key (id) 
       references JIOlapClientConnection;

    alter table JIMondrianConnection 
       add constraint FK8yiwytorg3lwqq1gag9fng7rf 
       foreign key (reportDataSource) 
       references JIResource;

    alter table JIMondrianConnection 
       add constraint FKamcjhut3kc0ko4rypemusdn7d 
       foreign key (mondrianSchema) 
       references JIFileResource;

    alter table JIMondrianConnectionGrant 
       add constraint FKdhgtynksn8sijhvtw07fnnmdr 
       foreign key (accessGrant) 
       references JIFileResource;

    alter table JIMondrianConnectionGrant 
       add constraint FKc2150iiriy6lqukm7w7ax6vw1 
       foreign key (mondrianConnectionId) 
       references JIMondrianConnection;

    alter table JIMondrianXMLADefinition 
       add constraint FKclv0lm19k3nvkmbv41epbfs34 
       foreign key (id) 
       references JIResource;

    alter table JIMondrianXMLADefinition 
       add constraint FKnmn2j9pevf2slm0i314ghs1sq 
       foreign key (mondrianConnection) 
       references JIMondrianConnection;

    alter table JIOlapClientConnection 
       add constraint FKqtji02a7ga296baj2y3avol24 
       foreign key (id) 
       references JIResource;

    alter table JIOlapUnit 
       add constraint FKtj0u3bnnfbe2h6w5v9jue5xr1 
       foreign key (id) 
       references JIResource;

    alter table JIOlapUnit 
       add constraint FKakvumwho658vijmoaaxddp4xo 
       foreign key (olapClientConnection) 
       references JIOlapClientConnection;

    alter table JIQuery 
       add constraint FK1ql6x3q59eti9h2r042ogoj3i 
       foreign key (id) 
       references JIResource;

    alter table JIQuery 
       add constraint FK6ff8ikqrr2celf9wvfbrcycpx 
       foreign key (dataSource) 
       references JIResource;

    alter table JIReportAlertToAddress 
       add constraint FKhaqpdt65o66idbve7gs97ye8p 
       foreign key (alert_id) 
       references JIReportJobAlert;

    alter table JIReportJob 
       add constraint FKntl9s5ul4oy4k9ws8u5wer55w 
       foreign key (owner) 
       references JIUser;

    alter table JIReportJob 
       add constraint FKkclub0l9io38j4su6crr9amd8 
       foreign key (scheduledResource) 
       references JIResource;

    alter table JIReportJob 
       add constraint FK8ymdkrb9uvvyi3xw9padxdxdv 
       foreign key (job_trigger) 
       references JIReportJobTrigger;

    alter table JIReportJob 
       add constraint FKrbhjr4v64eym1mg2du3fs9i95 
       foreign key (content_destination) 
       references JIReportJobRepoDest;

    alter table JIReportJob 
       add constraint FKo8dw7hsyef0xa1vg9feiu1mea 
       foreign key (mail_notification) 
       references JIReportJobMail;

    alter table JIReportJob 
       add constraint FKgg6i9vqj6rx0kgqxmoqigm3gr 
       foreign key (alert) 
       references JIReportJobAlert;

    alter table JIReportJobCalendarTrigger 
       add constraint FK89c4gqc5f5myrmfrc9a5gw7vb 
       foreign key (id) 
       references JIReportJobTrigger;

    alter table JIReportJobMailRecipient 
       add constraint FKoe0v23mvul37f23piq39ks6fh 
       foreign key (destination_id) 
       references JIReportJobMail;

    alter table JIReportJobOutputFormat 
       add constraint FKi5f8ideliwcf9juic989pn2lj 
       foreign key (report_job_id) 
       references JIReportJob;

    alter table JIReportJobParameter 
       add constraint FKh72kmrkm333g8ldlu7kybkrcd 
       foreign key (job_id) 
       references JIReportJob;

    alter table JIReportJobRepoDest 
       add constraint FKba2wg3iix8mr5wcjq6004ekvw 
       foreign key (ssh_private_key) 
       references JIResource;

    alter table JIReportJobSimpleTrigger 
       add constraint FK7gwgexkgjb6h4hn0166h2ttyk 
       foreign key (id) 
       references JIReportJobTrigger;

    alter table JIReportOptions 
       add constraint resource_id 
       foreign key (id) 
       references JIResource;

    alter table JIReportOptions 
       add constraint report_fk 
       foreign key (report_id) 
       references JIReportUnit;

    alter table JIReportOptionsInput 
       add constraint options_fk 
       foreign key (options_id) 
       references JIReportOptions;

    alter table JIReportThumbnail 
       add constraint FKhcdwx2qpiib9xtract2ecv31 
       foreign key (user_id) 
       references JIUser 
       on delete cascade;

    alter table JIReportThumbnail 
       add constraint FK8msuqfe2w3o9qjo81g8i6mgpi 
       foreign key (resource_id) 
       references JIResource 
       on delete cascade;

    alter table JIReportUnit 
       add constraint FK6cl7eluds59jg1emjofa30i23 
       foreign key (id) 
       references JIResource;

    alter table JIReportUnit 
       add constraint FK88u05b8n58ciemd3qcrd1jxn 
       foreign key (reportDataSource) 
       references JIResource;

    alter table JIReportUnit 
       add constraint FKcenakwnolc02r8xbdio30du9h 
       foreign key (query) 
       references JIQuery;

    alter table JIReportUnit 
       add constraint FKi2qw1u7yutrxh03xkrgx9o37d 
       foreign key (mainReport) 
       references JIFileResource;

    alter table JIReportUnitInputControl 
       add constraint FK8i0f45gnyhwcfrgueufsrvaw1 
       foreign key (input_control_id) 
       references JIInputControl;

    alter table JIReportUnitInputControl 
       add constraint FKkvxewxu2tyomdsg1kioplnfq 
       foreign key (report_unit_id) 
       references JIReportUnit;

    alter table JIReportUnitResource 
       add constraint FK18lcqhapddcvgcl52yqhil0a4 
       foreign key (resource_id) 
       references JIFileResource;

    alter table JIReportUnitResource 
       add constraint FK2fjktehjwog75dmp2rrfgm958 
       foreign key (report_unit_id) 
       references JIReportUnit;

    alter table JIRepositoryCache 
       add constraint FKah8ma0bnkbirohud6lvenjt0k 
       foreign key (item_reference) 
       references JIRepositoryCache;

    alter table JIResource 
       add constraint FKtnvtjq7s7hviyarfmomkokjm4 
       foreign key (parent_folder) 
       references JIResourceFolder;

    alter table JIResource 
       add constraint FKc2qblpikow4ay35q0xgf9rjub 
       foreign key (childrenFolder) 
       references JIResourceFolder;

    alter table JIResourceFolder 
       add constraint FKduwulvl4qwqkqpxonyuer65fi 
       foreign key (parent_folder) 
       references JIResourceFolder;

    alter table JIRole 
       add constraint FKmrf25easnd1emk6juaeot4dkn 
       foreign key (tenantId) 
       references JITenant;

    alter table JITenant 
       add constraint FKqupdx83verq7860nxsd6l24y1 
       foreign key (parentId) 
       references JITenant;

    alter table JIUser 
       add constraint FKdnd0cy83h5cc2ex1375wek3wf 
       foreign key (tenantId) 
       references JITenant;

    alter table JIUserRole 
       add constraint FKrnaojg2v9yc6u72wrl6pmmi60 
       foreign key (userId) 
       references JIUser;

    alter table JIUserRole 
       add constraint FKska4g96yuc7dsyrskhot6nccp 
       foreign key (roleId) 
       references JIRole;

    alter table JIVirtualDatasource 
       add constraint FK8jua4kahyslb99ni7bbyjxdf6 
       foreign key (id) 
       references JIResource;

    alter table JIVirtualDataSourceUriMap 
       add constraint FKbpwmqrxy4onvvbsnole8icjic 
       foreign key (resource_id) 
       references JIResource;

    alter table JIVirtualDataSourceUriMap 
       add constraint FK94bfn67jetx6l0ykl2g9n37w1 
       foreign key (virtualDS_id) 
       references JIVirtualDatasource;

    alter table JIXMLAConnection 
       add constraint FK27s5ja8sxgrylp7cf0wyscl79 
       foreign key (id) 
       references JIOlapClientConnection;

    alter table ProfilingRecord 
       add constraint FKct2sphgl7gfep2dl9ub4npyge 
       foreign key (parent_id) 
       references ProfilingRecord;
create index idx12_bundle_id_idx on JIDomainDatasourceBundle (bundle_id);
create index JIResource_childrenFolder_idx on JIResource (childrenFolder);
create index idx13_ref_id_idx on JIDomainDatasourceDSRef (ref_id);
create index JIResource_parent_folder_index on JIResource (parent_folder);
create index idx21_recipientobjclass_idx on JIObjectPermission (recipientobjectclass);
create index idx22_recipientobjid_idx on JIObjectPermission (recipientobjectid);
create index JILogEvent_userId_index on JILogEvent (userId);
create index idx36_resource_id_idx on JIVirtualDataSourceUriMap (resource_id);
create index uri_index on JIObjectPermission (uri);
create index JIUserRole_userId_index on JIUserRole (userId);
create index JITenant_parentId_index on JITenant (parentId);
create index JIRole_tenantId_index on JIRole (tenantId);
create index JIUserRole_roleId_index on JIUserRole (roleId);
create index idx23_olapClientConnection_idx on JIOlapUnit (olapClientConnection);
create index JIReportUnit_mainReport_index on JIReportUnit (mainReport);
create index JIReportUnit_query_index on JIReportUnit (query);
create index JIQuery_dataSource_index on JIQuery (dataSource);
create index idx28_resource_id_idx on JIReportThumbnail (resource_id);
create index idx31_report_unit_id_idx on JIReportUnitInputControl (report_unit_id);
create index idx32_report_unit_id_idx on JIReportUnitResource (report_unit_id);
create index idx29_reportDataSource_idx on JIReportUnit (reportDataSource);
create index idx30_input_ctrl_id_idx on JIReportUnitInputControl (input_control_id);
create index idx33_resource_id_idx on JIReportUnitResource (resource_id);
create index idx17_reportDataSource_idx on JIMondrianConnection (reportDataSource);
create index ProfilingRecord_parent_id_idx on ProfilingRecord (parent_id);
create index idx20_mondrianConnection_idx on JIMondrianXMLADefinition (mondrianConnection);
create index idx15_input_ctrl_id_idx on JIInputControlQueryColumn (input_control_id);
create index idx8_audit_event_id_idx on JIAuditEventPropertyArchive (audit_event_id);
create index idx16_mondrianSchema_idx on JIMondrianConnection (mondrianSchema);
create index JIReportOptions_report_id_idx on JIReportOptions (report_id);
create index idx18_accessGrant_idx on JIMondrianConnectionGrant (accessGrant);
create index idx19_mondrianConnectionId_idx on JIMondrianConnectionGrant (mondrianConnectionId);
create index idx35_parent_folder_idx on JIResourceFolder (parent_folder);
create index JIResourceFolder_version_index on JIResourceFolder (version);
create index JIFileResource_reference_index on JIFileResource (reference);
create index JIInputCtrl_list_of_values_idx on JIInputControl (list_of_values);
create index JIInputControl_list_query_idx on JIInputControl (list_query);
create index JIResourceFolder_hidden_index on JIResourceFolder (hidden);
create index JIInputControl_data_type_index on JIInputControl (data_type);
create index idx34_item_reference_idx on JIRepositoryCache (item_reference);
create index idx1_adhocStateId_idx on JIAdhocDataView (adhocStateId);
create index idxA1_resource_id_idx on JICustomDatasourceResource (resource_id);
create index idx2_reportDataSource_idx on JIAdhocDataView (reportDataSource);
create index idx27_destination_id_idx on JIReportJobMailRecipient (destination_id);
create index idx14_repodest_id_idx on JIFTPInfoProperties (repodest_id);
create index JIUser_tenantId_index on JIUser (tenantId);
create index idxA3_report_id_idx on JIAdhocDataViewBasedReports (report_id);
create index idx5_adhocStateId_idx on JIAdhocReportUnit (adhocStateId);
create index idx3_input_ctrl_id_idx on JIAdhocDataViewInputControl (input_control_id);
create index idx4_resource_id_idx on JIAdhocDataViewResource (resource_id);
create index JIReportJob_alert_index on JIReportJob (alert);
create index idx25_content_destination_idx on JIReportJob (content_destination);
create index JIReportJob_owner_index on JIReportJob (owner);
create index idx24_alert_id_idx on JIReportAlertToAddress (alert_id);
create index JIReportJob_job_trigger_index on JIReportJob (job_trigger);
create index idx26_mail_notification_idx on JIReportJob (mail_notification);
create index idx7_audit_event_id_idx on JIAuditEventProperty (audit_event_id);
create index idx6_state_id_idx on JIAdhocStateProperty (state_id);
create index idxA2_resource_id_idx on JIDashboardModelResource (resource_id);
