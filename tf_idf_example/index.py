import re

import postgresql

db = postgresql.open('pq://postgres:sa@localhost:5432/tfidf')

DOCUMENT1 = "document1.txt"
DOCUMENT2 = "document2.txt"
DOCUMENT3 = "document3.txt"


def parse_document(path):
    document_id = create_document(path)[0][0]

    with open(path, 'r') as f:
        for line in f:
            for word in line.split():
                word = " ".join(re.findall("[a-zA-Z]+", word)).lower()
                if len(word) < 3:
                    add_break_word(word)
                else:
                    add_word(document_id, word)


def create_document(name):
    select = db.prepare("SELECT * FROM document WHERE name=$1")
    select = select(name)
    if len(select) == 0:
        insert = db.prepare("INSERT INTO document(name) VALUES ($1);")
        insert(name)
    select = db.prepare("SELECT id FROM document WHERE name=$1;")
    return select(name)


def add_word(document_id, word):
    bad_word_select = db.query("SELECT word FROM break_words WHERE word='"+word+"'")
    if len(bad_word_select) != 0:
        return
    document = db.prepare("SELECT document_id,count FROM words WHERE word=$1 AND document_id=$2")
    document = document(word, document_id)
    if len(document) == 0:
        insert = db.prepare("INSERT INTO words(word, document_id,count) VALUES ($1, $2, $3)")
        insert(word, document_id, 1)
    else:
        count = document[0][1]
        count += 1
        update = db.prepare("UPDATE words SET count=$1 WHERE document_id=$2 AND word=$3")
        update(count, document_id, word)


def add_break_word(word):
    break_word = db.prepare("SELECT word FROM break_words WHERE word=$1;")
    result = break_word(word)
    if len(result) == 0:
        insert = db.prepare("INSERT INTO break_words(word) VALUES ($1)")
        insert(word)


parse_document(DOCUMENT1)
parse_document(DOCUMENT2)
parse_document(DOCUMENT3)
