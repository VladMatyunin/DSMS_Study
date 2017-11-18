import re

import psycopg2

try:
    conn = psycopg2.connect("dbname=tf_idf user=postgres host=localhost port=5432 password=sa")

    cur = conn.cursor()
    for i in range(0, 5000):
        query = """INSERT INTO test_bloat VALUES """
        tup = []
        for j in range(0, 1000):
            pointer = str(i*1000+j)
            tup.append((pointer, "NAME"+pointer))
        args_str = ','.join(cur.mogrify('(%s, %s)', x) for x in tup)
        cur.execute("INSERT INTO test_bloat VALUES " + args_str)
        conn.commit()
except:
    print("I am unable to connect to the database")
    raise