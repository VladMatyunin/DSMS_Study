WITH total1 as (
  SELECT *
  FROM words as total1
  WHERE doc_id = 1 AND size = 3),
total2 as (SELECT * FROM words WHERE doc_id = 2 AND size=3),
un as (SELECT value from total1 UNION ALL SELECT value from total2),

intr as (SELECT value FROM total1 INTERSECT ALL SELECT value FROM total2),
tot1 as (SELECT count(*) FROM intr),
tot2 as (Select count(*) FROM un)
SELECT (((SELECT * FROM tot1)::DECIMAL)/((SELECT * FROM tot2)::DECIMAL))::DECIMAL;



WITH total1 as (
    SELECT *
    FROM words as total1
    WHERE doc_id = 1 AND size = 3),
    total2 as (SELECT * FROM words WHERE doc_id = 2 AND size=3)
    SELECT value from total1 INTERSECT SELECT value from total2;

SELECT value, doc_id FROM words as w1
WHERE w1.doc_id=1 AND w1.value NOT IN (SELECT value FROM words as w2 WHERE w2.doc_id=2)

