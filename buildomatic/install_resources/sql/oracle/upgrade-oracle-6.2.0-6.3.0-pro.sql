--
--
-- 6.2.0 to 6.3.0
--
-- This is a placeholder file for the js-upgrade-samedb.sh/bat script
--
-- Create a table for Azure SQL Data Source
    create table JIAzureSqlDatasource (
        id number(19,0) not null,
        keyStore_id number(19,0) not null,
        keyStorePassword nvarchar2(100),
        keyStoreType nvarchar2(25),
        subscriptionId nvarchar2(100),
        serverName nvarchar2(100) not null,
        dbName nvarchar2(100) not null,
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
    alter table JIReportJobRepoDest add ssh_private_key number(19,0);

    alter table JIReportJobRepoDest
        add constraint FKEA477EBE3C5B87D0
        foreign key (ssh_private_key)
        references JIResource;
