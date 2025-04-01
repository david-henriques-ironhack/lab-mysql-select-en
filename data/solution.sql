USE pubs;

#CHALLENGE 1
SELECT
authors.au_id AS AUTHOR_ID,
authors.au_lname AS LAST_NAME,
authors.au_fname AS FIRST_NAME,
titles.title AS TITLE,
publishers.pub_name AS PUBLISHER
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id;

#CHALLENGE 2

SELECT
authors.au_id AS AUTHOR_ID,
authors.au_lname AS LAST_NAME,
authors.au_fname AS FIRST_NAME,
publishers.pub_name AS PUBLISHER,
COUNT(titles.title) AS TITLE_COUNT
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY 1,2,3,4;

#CHALLENGE 3

SELECT
authors.au_id AS AUTHOR_ID,
authors.au_lname AS LAST_NAME,
authors.au_fname AS FIRST_NAME,
SUM(sales.qty) AS TOTAL
FROM authors
INNER JOIN titleauthor ON authors.au_id = titleauthor.au_id
INNER JOIN titles ON titleauthor.title_id = titles.title_id
INNER JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY 1,2,3
ORDER BY TOTAL DESC
LIMIT 3;

#CHALLENGE 4

SELECT
authors.au_id AS AUTHOR_ID,
authors.au_lname AS LAST_NAME,
authors.au_fname AS FIRST_NAME,
SUM(sales.qty) AS TOTAL
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN titles ON titleauthor.title_id = titles.title_id
LEFT JOIN sales ON titleauthor.title_id = sales.title_id
GROUP BY 1,2,3
ORDER BY TOTAL DESC
;