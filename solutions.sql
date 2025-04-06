USE pubs;

SHOW tables;

/* Challenge 1 - Who Have Published What At Where? */
SELECT a.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, title AS TITLE, pub_name AS PUBLISHER 
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
INNER JOIN titles t ON ta.title_id = t.title_id
INNER JOIN publishers p ON t.pub_id = p.pub_id;

/* Challenge 2 - Who Have Published How Many At Where? */
SELECT a.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, pub_name AS PUBLISHER, COUNT(*)
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id 
INNER JOIN titles t ON ta.title_id = t.title_id
INNER JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME, PUBLISHER;

/* Challenge 3 - Best Selling Authors */
SELECT a.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, SUM(qty) AS TOTAL
FROM authors a
INNER JOIN titleauthor ta ON a.au_id = ta.au_id
INNER JOIN sales s ON ta.title_id = s.title_id
GROUP BY AUTHOR_ID
ORDER BY TOTAL DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking */
SELECT a.au_id AS AUTHOR_ID, au_lname AS LAST_NAME, au_fname AS FIRST_NAME, COALESCE(SUM(qty), 0) AS TOTAL
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales s ON ta.title_id = s.title_id
GROUP BY AUTHOR_ID
ORDER BY TOTAL DESC;
