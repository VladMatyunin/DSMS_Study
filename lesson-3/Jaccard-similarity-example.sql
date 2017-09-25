--Task: find Jaccard similarity for multiple values ['a','b','c','d','e'] and 
--      ['c','d','e','f','g','h'] without creating tables in 1 query
Select ((Select count(*) from 
            (select unnest(array['a','b','c','d','e']) as id
            INTERSECT select unnest(array['c','d','e','f','g','h']) as id) as t1)::decimal
            /
        (Select count(*) from
            (select unnest(array['a','b','c','d','e']) as id
            UNION select unnest(array['c','d','e','f','g','h']) as id) as t2)::decimal
        );

--Task: find Jaccard similarity for multiple values ['a','a','a','b'] and 
--      ['a','a','b','b','c'] without creating tables in 1 query
--      TODO: change unnest arrays to new values
Select ((Select count(*) from
            (select unnest(array['a','a','a','b']) as id
            INTERSECT ALL select unnest(array['c','d','e','f','g','h']) as id) as t1)::decimal
            /
        (Select count(*) from
            (select unnest(array['a','a','b','b','c']) as id
            UNION ALL select unnest(array['c','d','e','f','g','h']) as id) as t2)::decimal );




