SELECT word, document_id, max(count) as mmmax FROM words WHERE document_id=1 OR document_id=2
  AND word NOT IN (SELECT word FROM break_words)
GROUP BY CUBE (word,document_id,count)
HAVING count>1
ORDER BY mmmax DESC LIMIT 16