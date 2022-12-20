/*3.	[ 15 ]	Write an anonymous PL/SQL to display a report as follows.
a.	For each publisher, ordered by name, display :
"Publisher <pubname> (<pubid>), located in <city>: list of author first names"
“Total authors for <pubname> is X”
b.	You MUST use at least one For Loop in your solution.
c.	Sample output:
*/

DECLARE
    cpubid CHAR(4);
    vauthors VARCHAR2(1024);
    ncount NUMBER := 0;
    CURSOR publisher_cur IS SELECT * FROM Publisher;
    CURSOR authors_cur IS 
        SELECT * 
        FROM Author a
            JOIN TitleAuthor ta on ta.auid = a.auid
            JOIN Title t on t.titleid = ta.titleid
        WHERE t.pubid = cpubid
        ORDER BY a.aulname;
BEGIN
    FOR publisher in publisher_cur LOOP
        DBMS_OUTPUT.PUT('Publisher: ' || publisher.pubid || ': ' || publisher.pubname || ': ');
        cpubid := publisher.pubid;
        FOR author in authors_cur LOOP
            vauthors := vauthors || author.aulname || ', ';
            ncount := ncount + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(SUBSTR(vauthors, 1, LENGTH(vauthors)-2));
        DBMS_OUTPUT.PUT_LINE('Total Authors for ' || publisher.pubname || ' is ' || ncount);
        vauthors := '';
        ncount := 0;
    END LOOP;

END;