/*
Create a PL/SQL function called Author_titles that receives as a parameter the author ID 
and returns the titles of books that they have written.
The names must be returned as a string with commas separating names.
use this function in a query.
*/

create or replace function Author_titles(authorid char)
return varchar2
is
   v_titles varchar2(1000);
   cursor titlecur is
      select title from Title t
        JOIN titleauthor ta on ta.titleid = t.titleid
      where ta.auid = authorid;
begin
     for titlerecord in titlecur
     loop
         v_titles :=  v_titles ||  ' *** ' || titlerecord.title;
     end loop;
     -- remove extra  , at the beginning
     return  ltrim(v_titles,' *** ');
end;

/

select DISTINCT auid, Author_titles(auid) FROM Author order by auid;
