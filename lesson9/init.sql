CREATE TABLE test_part (
  id  INTEGER PRIMARY KEY,
  type INTEGER,
  name VARCHAR(50)
);
CREATE Or Replace FUNCTION fnc_type_counter()
  RETURNS TRIGGER AS $body$
  DECLARE
  BEGIN
    IF NOT EXISTS(SELECT * From pg_tables where tablename='''test_part'||new.type||'') THEN
        Execute 'Create table if not exists test_part'||new.type||'(like test_part including all) inherits(test_part);';
        EXECUTE 'Alter table test_part'||new.type||' add constraint part_check'||new.type||' check(type>=1 and type<100000)';

      END If;
    EXECUTE 'Insert Into test_part'||new.type||' values('||new.id || ',' ||new.type|| ','''||new.name||''')';
    RETURN NULL;
  End
  $body$
  LANGUAGE plpgsql VOLATILE;

CREATE TRIGGER trg_insert BEFORE INSERT ON test_part FOR EACH ROW EXECUTE PROCEDURE fnc_type_counter();

INSERT INTO test_part(id,type,name) VALUES (102,101,'test1'),(104,103,'test1'),(105,109,'test1'),
  (1,1,'test1'), (2,2,'test1'),(3,3,'test1');

EXPLAIN ANALYSE SELECT * FROM test_part WHERE type=100