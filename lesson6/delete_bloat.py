import re

import psycopg2

try:
    conn = psycopg2.connect("dbname=tf_idf user=postgres host=localhost port=5432 password=sa")

    cur = conn.cursor()
    cur.execute("delete from test_bloat WHERE id<1000000")
    conn.commit()
except:
    print("I am unable to connect to the database")
    raise