import re

import psycopg2

try:
    conn = psycopg2.connect("dbname=tf_idf user=postgres host=localhost port=5432 password=sa")

    cur = conn.cursor()
    for i in range(1, 2):
        tup = []
        for j in range(0, 25):
            pointer = str(i*1000+j)
            tup.append((pointer, "NAME"+pointer))
        args_str = ','.join(cur.mogrify('(%s, %s)', x) for x in tup)
        cur.execute("INSERT INTO test_index VALUES " + args_str)
        conn.commit()
except:
    print("I am unable to connect to the database")
    raise