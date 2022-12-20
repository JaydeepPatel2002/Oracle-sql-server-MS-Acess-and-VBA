/*
List the title in uppercase, it's publishing date as 3 char month,
2 digit date, and 2 digit year, it's year to date sales, for all titles
published between 15-JUN-98 and the end of june
*/
SELECT 
    UPPER(Title),
    to_char(pubdate, 'Mon') || ' ' || to_char(pubdate, 'dd') || ' ' || to_char(pubdate, 'yy') as pubdate,
    ytdsales
    FROM Title
    WHERE pubdate between '15-JUN-98' and '30-JUN-98';