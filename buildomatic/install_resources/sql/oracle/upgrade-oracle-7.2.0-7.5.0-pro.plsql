--
--
-- 7.2.0 to 7.5.0 in-place (samedb) upgrade script
--
--

-- Change column type from "nvarchar2(100)" to "nvarchar2(150)"
alter table JIAwsDatasource modify accessKey nvarchar2(150)
/

-- Change column type from "nvarchar2(100)" to "nvarchar2(255)"
alter table JIAwsDatasource modify secretKey nvarchar2(255)
/

-- 
-- 2020-4-17 fix for JS-57213 -- rtinsman
-- 
-- We need to resort to PL/SQL because there are two possible constraints to drop,
-- because constraint names changed with the Hibernate upgrade in 7.2, and Oracle doesn't have 
-- a way to drop the constraint if it exists, but not throw an error if it doesn't
-- 
-- We select the constraints on the JIAccessEvent table (type 'R' stands for a foreign key constraint),
-- then loop over the constraints and use EXEC IMMEDIATE to construct the drop SQL.
--
BEGIN
  -- get a cursor with constraint names
  FOR access_constr IN (
    SELECT constraint_name
    FROM user_constraints
    WHERE table_name = 'JIACCESSEVENT'
    AND constraint_type = 'R'
  )
  LOOP
    -- for each row, exec the "drop constraint"
    EXECUTE IMMEDIATE('ALTER TABLE JIACCESSEVENT DROP CONSTRAINT ' || access_constr.constraint_name);
  END LOOP;
END;
/
