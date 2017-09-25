<h1>Мультимножество vs Множество</h1>
Во множестве нет дупликатов
(Select name from student) 
UNION 
(select name from student)
# дупликаты удалятся
# если union all, то тогда будут дупликаты
# если разные типы в 2 выражениях, то будет ошибка
в oracle ковертация to_char(...)
в postgres ..::varchar

(Select name from student) 
MINUS 
(Select name from old_student)

- убрать все, где есть Петр, без NOT IN
(Select name from student)
MINUS 
- oracle
(Select 'Петр' as name from dual)
dual1 - служебная таблица oracle (можно вытащить текущую дату)

в старых версиях oracle не было инкремента, нужен был триггер
select seq_name_nextval from dual;
c 2.11 появилась консрукция xID=seq_name.nextval
разница в performance

- в postgres
Select 'Петр'::varchar as name 

Даны множества А и Б A={1,3,1,4,5} B={3,4,5,6,null}

Select 1 as id 
UNION
Select 3 as id
UNION
...

sim(A,B) = |A ^ B| / |A V B|;
- JAccard Similarity of sets
- Схожесть данных во множествах 
