/* Challenge 1 - Who Have Published What At Where? */

CREATE TABLE challenge_1 AS

SELECT
    pubs.authors.au_id AS 'AUTHOR ID',
	pubs.authors.au_lname AS 'LAST NAME',
	pubs.authors.au_fname AS 'FIRST NAME',
    /* pubs.titleauthor.title_id AS "TITLE ID", */
    pubs.titles.title AS 'TITLE',
	pubs.publishers.pub_name AS 'PUBLISHER'

FROM pubs.authors

JOIN pubs.titleauthor
ON pubs.titleauthor.au_id = pubs.authors.au_id

JOIN pubs.titles
ON pubs.titleauthor.title_id = pubs.titles.title_id

JOIN pubs.publishers
ON pubs.publishers.pub_id = pubs.titles.pub_id;

/* SELECT COUNT(*)
FROM pubs.titleauthor; */

SELECT * FROM challenge_1;

/* */
/* */
/* */
/* */
/* Challenge 2 - Who Have Published How Many At Where? */

CREATE TABLE challenge_1 AS
SELECT
    pubs.authors.au_id AS 'AUTHOR_ID',
	pubs.authors.au_lname AS 'LAST_NAME',
	pubs.authors.au_fname AS 'FIRST_NAME',
    /* pubs.titleauthor.title_id AS "TITLE ID", */
    pubs.titles.title AS 'TITLE',
	pubs.publishers.pub_name AS 'PUBLISHER'
FROM pubs.authors
JOIN pubs.titleauthor
ON pubs.titleauthor.au_id = pubs.authors.au_id
JOIN pubs.titles
ON pubs.titleauthor.title_id = pubs.titles.title_id
JOIN pubs.publishers
ON pubs.publishers.pub_id = pubs.titles.pub_id;


SELECT
AUTHOR_ID,
LAST_NAME,
FIRST_NAME,
PUBLISHER,
COUNT(TITLE)
from challenge_1
GROUP BY
AUTHOR_ID,
LAST_NAME,
FIRST_NAME,
PUBLISHER;

/* */
/* */
/* */
/* */
/* Challenge 3 - Best Selling Authors*/

SELECT
    pubs.authors.au_id AS "AUTHOR ID",
	pubs.authors.au_lname AS "LAST NAME",
	pubs.authors.au_fname AS "FIRST NAME",
	/* pubs.sales.title_id AS "TOTAL",*/
    COUNT(pubs-sales-title_id) AS "TOTAL"
FROM pubs.authors

JOIN pubs.titleauthor ON pubs.titleauthor.au_id = pubs.authors.au_id
JOIN pubs.sales ON pubs.sales.title_id = pubs.titleauthor.title_id

GROUP BY au_id, au_lname, au_fname

ORDER BY TOTAL DESC
LIMIT 3;




SELECT
    pubs.authors.au_id AS "AUTHOR ID",
    pubs.authors.au_lname AS "LAST NAME",
    pubs.authors.au_fname AS "FIRST NAME",
    SUM(pubs.sales.qty) AS TOTAL
FROM pubs.authors

JOIN pubs.titleauthor
    ON pubs.titleauthor.au_id = pubs.authors.au_id
JOIN pubs.sales
    ON pubs.sales.title_id = pubs.titleauthor.title_id

GROUP BY
    pubs.authors.au_id,
    pubs.authors.au_lname,
    pubs.authors.au_fname

ORDER BY TOTAL DESC
LIMIT 3;


/* */
/* */
/* */
/* */
/* Challenge 4 - Best Selling Authors Ranking */

SELECT
    pubs.authors.au_id AS "AUTHOR ID",
    pubs.authors.au_lname AS "LAST NAME",
    pubs.authors.au_fname AS "FIRST NAME",
    COALESCE(SUM(pubs.sales.qty), 0) AS TOTAL
FROM pubs.authors

LEFT JOIN pubs.titleauthor
    ON pubs.titleauthor.au_id = pubs.authors.au_id
LEFT JOIN pubs.sales
    ON pubs.sales.title_id = pubs.titleauthor.title_id

GROUP BY
    pubs.authors.au_id,
    pubs.authors.au_lname,
    pubs.authors.au_fname

ORDER BY TOTAL DESC
LIMIT 23;