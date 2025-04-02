-- SOLUTIONS

-- Challenge 1. In this challenge you will write a MySQL `SELECT` query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:

CREATE TEMPORARY TABLE pubs.titles_and_author_ids
SELECT au_id, title, pub_id, ytd_sales
FROM pubs.titles
RIGHT JOIN pubs.titleauthor -- using RIGHT as there are titles from different authors
ON titles.title_id = titleauthor.title_id;

CREATE TEMPORARY TABLE pubs.titles_and_authors
SELECT titles_and_author_ids.au_id, au_fname, au_lname, title, pub_id, ytd_sales
FROM pubs.titles_and_author_ids
LEFT JOIN pubs.authors -- using LEFT to keep all titles, even if there is no author.
ON titles_and_author_ids.au_id = authors.au_id;

CREATE TEMPORARY TABLE pubs.titles_with_authors_and_publishers
SELECT titles_and_authors.au_id, au_fname, au_lname, title, pub_name
FROM pubs.titles_and_authors
LEFT JOIN pubs.publishers -- using LEFT to keep all titles, even if there is no publisher.
ON titles_and_authors.pub_id = publishers.pub_id;

SELECT au_id, au_fname, au_lname, title, pub_name
FROM pubs.titles_with_authors_and_publishers
ORDER BY au_id ASC;

-- Challenge 2. Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. Your output should look something like below:

SELECT au_id, au_lname, au_fname, pub_name, COUNT(title)
FROM pubs.titles_with_authors_and_publishers
GROUP BY pub_name, au_id, au_lname, au_fname
ORDER BY au_id DESC

-- Challenge 3. Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

SELECT au_id, au_lname, au_fname, SUM(ytd_sales)
FROM pubs.titles_and_authors
GROUP BY au_id, au_lname, au_fname
ORDER BY SUM(ytd_sales) DESC
LIMIT 3

-- Challenge 4. Best Selling Authors Ranking

SELECT au_id, au_lname, au_fname, SUM(ytd_sales)
FROM pubs.titles_and_authors
GROUP BY au_id, au_lname, au_fname
ORDER BY SUM(ytd_sales) DESC