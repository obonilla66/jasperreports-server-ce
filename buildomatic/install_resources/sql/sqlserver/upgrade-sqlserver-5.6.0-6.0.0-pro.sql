--
-- 5.6.0 to 6.0.0
--
-- Added new dashboard resource
-- Created table JIReportThumbnail to store thumbnails of reports
--

    create table JIReportThumbnail (
        id numeric(19,0) identity not null,
        user_id numeric(19,0) not null,
        resource_id numeric(19,0) not null,
        thumbnail varbinary(max) not null,
        primary key (id),
        unique (user_id, resource_id)
    );

    alter table JIReportThumbnail
        add constraint FKFDB3DED932282198
        foreign key (user_id)
        references JIUser
        on delete cascade;

    alter table JIReportThumbnail
        add constraint FKFDB3DED9F254B53E
        foreign key (resource_id)
        references JIResource
        on delete cascade;


-- increase column size from 1000 to max
ALTER TABLE JIDashboardFrameProperty ALTER COLUMN propertyValue nvarchar(max);

-- change column size from 1000 to max
ALTER TABLE JIReportOptionsInput ALTER COLUMN input_value varbinary(max);

-- drop tables that are no longer used
DROP TABLE JIAdhocChartMeasure;
DROP TABLE JIAdhocColumn;
DROP TABLE JIAdhocGroup;
DROP TABLE JIAdhocTableSortField;
DROP TABLE JIAdhocXTabColumnGroup;
DROP TABLE JIAdhocXTabMeasure;
DROP TABLE JIAdhocXTabRowGroup;    

    create table JIAdhocDataViewBasedReports (
        adhoc_data_view_id numeric(19,0) not null,
        report_id numeric(19,0) not null,
        report_index int not null,
        primary key (adhoc_data_view_id, report_index)
    );

    create table JIDashboardModel (
        id numeric(19,0) not null,
        foundationsString nvarchar(max) null,
        resourcesString nvarchar(max) null,
        defaultFoundation int null,
        primary key (id)
    );

    create table JIDashboardModelResource (
        dashboard_id numeric(19,0) not null,
        resource_id numeric(19,0) not null,
        resource_index int not null,
        primary key (dashboard_id, resource_index)
    );

    alter table JIAdhocDataViewBasedReports
        add constraint FKFFD9AFF5B22FF3B2
        foreign key (adhoc_data_view_id)
        references JIAdhocDataView;

    alter table JIAdhocDataViewBasedReports
        add constraint FKFFD9AFF5830BA6DB
        foreign key (report_id)
        references JIReportUnit;

    alter table JIDashboardModel
        add constraint FK8BB7D814A8BF376D
        foreign key (id)
        references JIResource;

    alter table JIDashboardModelResource
        add constraint FK273EAC4230711005
        foreign key (dashboard_id)
        references JIDashboardModel;

    alter table JIDashboardModelResource
        add constraint FK273EAC42F254B53E
        foreign key (resource_id)
        references JIResource;


