
/* Challenge 1 - Who Have Published What At Where?*/
SELECT pubs.titleauthor.au_id AS AUTHOR_ID, pubs.authors.au_lname AS LAST_NAME, pubs.authors.au_fname AS FIRST_NAME, pubs.titles.title AS TITLE, pubs.publishers.pub_name AS PUBLISHER
FROM pubs.titleauthor
INNER JOIN pubs.authors 
ON pubs.titleauthor.au_id = pubs.authors.au_id
INNER JOIN pubs.titles 
ON pubs.titleauthor.title_id = pubs.titles.title_id
INNER JOIN pubs.publishers 
ON pubs.titles.pub_id = pubs.publishers.pub_id;

/* Challenge 2 - Who Have Published How Many At Where?*/
SELECT pubs.titleauthor.au_id AS AUTHOR_ID, pubs.authors.au_lname AS LAST_NAME, pubs.authors.au_fname AS FIRST_NAME, pubs.publishers.pub_name AS PUBLISHER,COUNT(pubs.titles.title) as TITLE_COUNT
FROM pubs.titleauthor
INNER JOIN pubs.authors 
ON pubs.titleauthor.au_id = pubs.authors.au_id
INNER JOIN pubs.titles 
ON pubs.titleauthor.title_id = pubs.titles.title_id
INNER JOIN pubs.publishers 
ON pubs.titles.pub_id = pubs.publishers.pub_id
GROUP BY pubs.authors.au_id, pubs.authors.au_lname, pubs.authors.au_fname, pubs.publishers.pub_name
ORDER BY pubs.authors.au_id, pubs.publishers.pub_name;

/* Challenge 3 - Best Selling Authors*/
SELECT pubs.titleauthor.au_id AS AUTHOR_ID, pubs.authors.au_lname AS LAST_NAME, pubs.authors.au_fname AS FIRST_NAME, COUNT(pubs.titles.title) AS TOTAL
FROM pubs.titleauthor
INNER JOIN pubs.authors 
ON pubs.titleauthor.au_id = pubs.authors.au_id
INNER JOIN pubs.titles 
ON pubs.titleauthor.title_id = pubs.titles.title_id
INNER JOIN pubs.publishers 
GROUP BY pubs.authors.au_id, pubs.authors.au_lname, pubs.authors.au_fname
ORDER BY COUNT(pubs.titles.title) DESC
LIMIT 3;

/*Challenge 4 - Best Selling Authors Ranking*/
SELECT pubs.titleauthor.au_id AS AUTHOR_ID, pubs.authors.au_lname AS LAST_NAME, pubs.authors.au_fname AS FIRST_NAME, COUNT(pubs.titles.title) AS TOTAL
FROM pubs.titleauthor
INNER JOIN pubs.authors 
ON pubs.titleauthor.au_id = pubs.authors.au_id
INNER JOIN pubs.titles 
ON pubs.titleauthor.title_id = pubs.titles.title_id
INNER JOIN pubs.publishers 
GROUP BY pubs.authors.au_id, pubs.authors.au_lname, pubs.authors.au_fname
ORDER BY COUNT(pubs.titles.title) DESC
LIMIT 23