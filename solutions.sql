CREATE DATABASE pubs;

USE pubs;

-- challenge 1
SELECT * 
FROM titleauthor; /* final goal >> 25 rows*/

SELECT titleauthor.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, titles.title as TITLE, pub_name as PUBLISHER
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
;

-- challenge 2

SELECT COUNT(title_id)
FROM titleauthor; /* 25 titles*/

SELECT titleauthor.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, pub_name as PUBLISHER, COUNT(*) as TITLE_COUNT
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME, PUBLISHER
ORDER BY TITLE_COUNT DESC;

-- challenge 3
SELECT * 
FROM sales;

SELECT titleauthor.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, SUM(sales.qty) AS TITLE_SALES
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN sales ON sales.title_id = titles.title_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME
ORDER BY TITLE_SALES DESC
LIMIT 3;

-- challenge 4
SELECT titleauthor.au_id as AUTHOR_ID, authors.au_lname as LAST_NAME, authors.au_fname as FIRST_NAME, COALESCE(SUM(sales.qty), 0) AS TITLE_SALES
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON sales.title_id = titles.title_id
GROUP BY AUTHOR_ID, LAST_NAME, FIRST_NAME
ORDER BY TITLE_SALES DESC;

