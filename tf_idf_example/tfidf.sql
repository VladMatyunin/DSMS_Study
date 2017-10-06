WITH

    maxcount as (SELECT MAX(count),word_doc.word FROM (SELECT * FROM words WHERE word='general purpose' AND word NOT IN (SELECT word FROM break_words)) as word_doc GROUP BY word),
    idf as (SELECT log(2, (SELECT count(*) FROM document)::DECIMAL)
    /
    (SELECT (SELECT count(*) FROM words WHERE word=(SELECT word FROM maxcount))::DECIMAL) AS idf)
    (SELECT document_id, count/((SELECT count From maxcount)*(SELECT * FROM idf)) as cc FROM words WHERE word=(SELECT word FROM maxcount));



