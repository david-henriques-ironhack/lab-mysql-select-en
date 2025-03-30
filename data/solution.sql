USE pubs;

/* Check some tables*/
SELECT *
FROM authors;

SELECT *
FROM titles;

SELECT *
FROM titleauthor;

SELECT *
FROM publishers;

SELECT *
FROM sales;

/* Challenge 1 - Who Have Published What At Where?*/
SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST_NAME', authors.au_fname AS 'FIRST_NAME', titles.title AS 'TITLE', publishers.pub_name AS 'PUBLISHERS'
FROM titleauthor
JOIN authors ON authors.au_id = titleauthor.au_id 
JOIN titles ON titles.title_id = titleauthor.title_id
JOIN publishers ON publishers.pub_id = titles.pub_id
ORDER BY titleauthor.au_id ASC;

/* Challenge 2 - Who Have Published How Many At Where?*/
SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST_NAME', authors.au_fname AS 'FIRST_NAME', publishers.pub_name AS 'PUBLISHERS', COUNT(*) AS TITLE_COUNT
FROM titleauthor
JOIN authors ON authors.au_id = titleauthor.au_id 
JOIN titles ON titles.title_id = titleauthor.title_id
JOIN publishers ON publishers.pub_id = titles.pub_id
GROUP BY titleauthor.au_id, authors.au_lname, authors.au_fname, publishers.pub_name 
ORDER BY titleauthor.au_id DESC, TITLE_COUNT ASC;
 
/* Challenge 3 - Best Selling Authors (qty -> quantity estimated)*/
SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST_NAME', authors.au_fname AS 'FIRST_NAME', SUM(sales.qty) AS TOTAL
FROM titleauthor
JOIN authors ON authors.au_id = titleauthor.au_id 
JOIN titles ON titles.title_id = titleauthor.title_id
JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.au_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC
LIMIT 3;
 
/* Challenge 4 - Best Selling Authors Ranking*/
SELECT titleauthor.au_id AS 'AUTHOR ID', authors.au_lname AS 'LAST_NAME', authors.au_fname AS 'FIRST_NAME', COALESCE(SUM(sales.qty),0) AS TOTAL
FROM titleauthor
JOIN authors ON authors.au_id = titleauthor.au_id 
JOIN titles ON titles.title_id = titleauthor.title_id
JOIN sales ON sales.title_id = titles.title_id
GROUP BY titleauthor.au_id, authors.au_lname, authors.au_fname
ORDER BY TOTAL DESC
LIMIT 23;