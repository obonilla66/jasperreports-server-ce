--
-- 5.6.0 to 6.0.0
--
-- Added new dashboard resource
-- Created table JIReportThumbnail to store thumbnails of reports
-- Bug 23374 - [case #20392] Large Dashboard elements breaks Postgres
-- Bug 37364 - Platform WAS 7.0.0.31 + Oracle 11g + IBM JDK 1.6: getting an error saving option of chart report
-- Bug 37405 - JBoss 7.1.1 + DB2: Error while saving report options
--

   create table JIReportThumbnail (
        id number(19,0) not null,
        user_id number(19,0) not null,
        resource_id number(19,0) not null,
        thumbnail blob not null,
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


-- migrate column type from nvarchar2(1000) to nclob
ALTER TABLE JIDashboardFrameProperty RENAME COLUMN propertyValue TO propertyValue_2;
ALTER TABLE JIDashboardFrameProperty ADD propertyValue nclob;
UPDATE JIDashboardFrameProperty SET propertyValue=propertyValue_2;
ALTER TABLE JIDashboardFrameProperty DROP (propertyValue_2);

-- migrate column type from raw(2000) to blob
ALTER TABLE JIReportOptionsInput RENAME COLUMN input_value TO input_value_2;
ALTER TABLE JIReportOptionsInput ADD input_value blob;
UPDATE JIReportOptionsInput SET input_value=input_value_2;
ALTER TABLE JIReportOptionsInput DROP (input_value_2);

-- drop tables that are no longer used
DROP TABLE JIAdhocChartMeasure CASCADE CONSTRAINTS;
DROP TABLE JIAdhocColumn CASCADE CONSTRAINTS;
DROP TABLE JIAdhocGroup CASCADE CONSTRAINTS;
DROP TABLE JIAdhocTableSortField CASCADE CONSTRAINTS;
DROP TABLE JIAdhocXTabColumnGroup CASCADE CONSTRAINTS;
DROP TABLE JIAdhocXTabMeasure CASCADE CONSTRAINTS;
DROP TABLE JIAdhocXTabRowGroup CASCADE CONSTRAINTS;

    create table JIAdhocDataViewBasedReports (
        adhoc_data_view_id number(19,0) not null,
        report_id number(19,0) not null,
        report_index number(10,0) not null,
        primary key (adhoc_data_view_id, report_index)
    );

    create table JIDashboardModel (
        id number(19,0) not null,
        foundationsString nclob,
        resourcesString nclob,
        defaultFoundation number(10,0),
        primary key (id)
    );

    create table JIDashboardModelResource (
        dashboard_id number(19,0) not null,
        resource_id number(19,0) not null,
        resource_index number(10,0) not null,
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
