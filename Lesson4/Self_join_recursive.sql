CREATE TABLE Path (
  GraphFrom VARCHAR(2),
  GraphTo VARCHAR(2),
  Distance INTEGER NOT NULL
);
INSERT INTO Path(GraphFrom, GraphTo, Distance) VALUES
  ('s', 'u', 3), ('s', 'x', 5),
  ('u', 'v', 6), ('u', 'x', 2),
  ('y', 's', 3), ('y', 'v', 7),
  ('x', 'u', 1), ('x', 'y', 6), ('x', 'v', 4),
  ('v', 'y', 2);

SELECT * FROM (
SELECT p1.GraphTo,p1.Distance FROM Path AS p1
    INNER JOIN Path AS p2 ON
p1.GraphFrom = p2.GraphTo AND
p1.GraphFrom = 's'
GROUP BY p1.GraphTo, p1.Distance ORDER BY Distance FETCH FIRST 1 ROW ONLY) AS total1
INNER JOIN Path AS p3 ON total1.GraphTo=p3.GraphTo;


SELECT * FROM Path as p1
INNER JOIN Path as p2 ON p1.Distance=p2.Distance AND p1.GraphFrom=p2.GraphFrom AND p1.GraphTo=p2.GraphTo
INNER JOIN Path as p3 ON p3.Distance= p2.Distance AND p3.GraphFrom=p2.GraphFrom AND p3.GraphTo=p2.GraphTo
INNER JOIN Path as p4 ON p4.Distance = p3.Distance AND p4.GraphFrom=p3.GraphFrom AND p4.GraphTo=p3.GraphTo
INNER JOIN Path as p5  ON p5.Distance = p4.Distance AND p5.GraphFrom=p4.GraphFrom AND p5.GraphTo=p4.GraphTo;


WITH fff as (SELECT VALUE 'j')
  , COALESCE(p1.Distance)+COALESCE(p2.Distance)+COALESCE(p3.Distance)+COALESCE(p4.Distance)+COALESCE(p5.Distance);


SELECT * FROM (Path as p1
  INNER JOIN Path as p2 ON  p1.GraphTo=p2.GraphFrom AND p1.GraphFrom='s' AND p2.GraphTo!=p1.GraphFrom
  INNER JOIN Path as p3 ON p2.GraphTo=p3.GraphFrom  AND p3.GraphTo!=p2.GraphFrom
  INNER JOIN Path as p4 ON p3.GraphTo=p4.GraphFrom AND p4.GraphTo!=p3.GraphFrom
  INNER JOIN Path as p5  ON p4.GraphTo=p5.GraphFrom  AND p5.GraphTo!=p4.GraphFrom);


With p12 as  ( SELECT p2.GraphTo,p1.Distance+p2.Distance as distance FROM Path as p1
  INNER JOIN Path as p2 ON  p1.GraphTo=p2.GraphFrom AND p1.GraphFrom='s' AND p2.GraphTo!=p1.GraphFrom
  ),
  p23 as (SELECT p3.GraphTo, p12.distance+p3.Distance as distance FROM p12
  INNER JOIN Path as p3 ON p12.GraphTo=p3.GraphFrom),
  p34 as (SELECT p4.GraphTo, p4.distance+p23.distance as distance FROM p23
  INNER JOIN Path as p4 ON p23.GraphTo=p4.GraphFrom),
  p45 as (SELECT p5.GraphTo, p5.distance+p34.distance as distance FROM p34
    INNER JOIN Path as p5 ON p34.GraphTo=p5.GraphFrom),
  total as (SELECT * FROM p12 UNION (SELECT * FROM p45) UNION (SELECT * FROM p34) UNION (SELECT * From p23))
SELECT min(distance) FROM total WHERE GraphTo='y'





