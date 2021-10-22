--
--
-- 6.2.0 to 6.3.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--
-- Create a table for Azure SQL Data Source
    create table JIAzureSqlDatasource (
        id numeric(19,0) not null,
        keyStore_id numeric(19,0) not null,
        keyStorePassword nvarchar(100) null,
        keyStoreType nvarchar(25) null,
        subscriptionId nvarchar(100) null,
        serverName nvarchar(100) not null,
        dbName nvarchar(100) not null,
        primary key (id)
    );

    alter table JIAzureSqlDatasource 
        add constraint FKAFE22203C001BAEA 
        foreign key (keyStore_id) 
        references JIResource;

    alter table JIAzureSqlDatasource 
        add constraint FKAFE2220387E4472B 
        foreign key (id) 
        references JIJdbcDatasource;


-- Add SShPrivate key to the Report Job
    alter table JIReportJobRepoDest add ssh_private_key numeric(19,0) null;

    alter table JIReportJobRepoDest
        add constraint FKEA477EBE3C5B87D0
        foreign key (ssh_private_key)
        references JIResource;
