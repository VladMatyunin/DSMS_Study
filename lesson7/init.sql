CREATE TABLE test_index (
 id INTEGER,
 name VARCHAR (40)
);

CREATE INDEX test_index_id ON test_index(id);
SET ENABLE_SEQSCAN =OFF;
