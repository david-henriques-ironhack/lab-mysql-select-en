USE pubs;

/* Challenge 1* Who Have Published What At Where?/

/* Joining Title author to authors table */
SELECT titleauthor.au_id, authors.au_lname, authors.au_fname
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id;

/* Joining Title author, authors and title table */
SELECT new_table.au_id, new_table.au_lname, new_table.au_fname,titles.pub_id, titles.title
FROM
(SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id) AS new_table
INNER JOIN titles
ON new_table.title_id = titles.title_id;

/* Joining Title author, authors, titles and publishers table together*/
SELECT new_table2.au_id AS AUTHOR_ID, new_table2.au_lname AS LAST_NAME, new_table2.au_fname AS FIRST_NAME,new_table2.title AS TITLE, publishers.pub_name AS PUBLISHER
FROM(SELECT new_table.au_id, new_table.au_lname, new_table.au_fname,titles.pub_id, titles.title
FROM
(SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id) AS new_table
INNER JOIN titles
ON new_table.title_id = titles.title_id) AS new_table2
INNER JOIN publishers
ON new_table2.pub_id = publishers.pub_id;

CREATE TEMPORARY TABLE temp_author_title_publisher AS
SELECT new_table2.au_id AS AUTHOR_ID, new_table2.au_lname AS LAST_NAME, new_table2.au_fname AS FIRST_NAME,new_table2.title AS TITLE, publishers.pub_name AS PUBLISHER
FROM(SELECT new_table.au_id, new_table.au_lname, new_table.au_fname,titles.pub_id, titles.title
FROM
(SELECT titleauthor.au_id, titleauthor.title_id, authors.au_lname, authors.au_fname
FROM titleauthor
INNER JOIN authors
ON titleauthor.au_id = authors.au_id) AS new_table
INNER JOIN titles
ON new_table.title_id = titles.title_id) AS new_table2
INNER JOIN publishers
ON new_table2.pub_id = publishers.pub_id;

/* Challenge 2 - Who Have Published How Many At Where? */

/* USE count for the titles */
SELECT temp_author_title_publisher.AUTHOR_ID, temp_author_title_publisher.LAST_NAME, temp_author_title_publisher.FIRST_NAME, temp_author_title_publisher.PUBLISHER, count(temp_author_title_publisher.TITLE) AS TITLE_COUNT
FROM temp_author_title_publisher
GROUP BY temp_author_title_publisher.AUTHOR_ID, temp_author_title_publisher.LAST_NAME, temp_author_title_publisher.FIRST_NAME, temp_author_title_publisher.PUBLISHER;

/* Challenge 3 - Best Selling Authors */

/* Join temporary table temp_author_title_publisher with titleauthor table to get the title_id*/
CREATE TEMPORARY TABLE temp_author_title_ID AS
SELECT temp_author_title_publisher.AUTHOR_ID, temp_author_title_publisher.LAST_NAME, temp_author_title_publisher.FIRST_NAME, temp_author_title_publisher.TITLE, titleauthor.title_id
FROM temp_author_title_publisher
INNER JOIN titleauthor
ON temp_author_title_publisher.AUTHOR_ID = titleauthor.au_id;

/* Join temporary table temp_author_title_ID with sales to get the QTY*/
CREATE TEMPORARY TABLE table_with_qty_sold AS
SELECT temp_author_title_ID.AUTHOR_ID, temp_author_title_ID.LAST_NAME, temp_author_title_ID.FIRST_NAME, temp_author_title_ID.title_id, sales.qty
FROM temp_author_title_ID
INNER JOIN sales
ON temp_author_title_ID.title_id = sales.title_id;

/* calculate best selling authors*/
SELECT table_with_qty_sold.AUTHOR_ID, table_with_qty_sold.LAST_NAME, table_with_qty_sold.FIRST_NAME, SUM(table_with_qty_sold.qty) AS TOTAL
FROM table_with_qty_sold
GROUP BY table_with_qty_sold.AUTHOR_ID, table_with_qty_sold.LAST_NAME, table_with_qty_sold.FIRST_NAME
ORDER BY TOTAL DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking*/

SELECT table_with_qty_sold.AUTHOR_ID, table_with_qty_sold.LAST_NAME, table_with_qty_sold.FIRST_NAME, SUM(table_with_qty_sold.qty) AS TOTAL
FROM table_with_qty_sold
GROUP BY table_with_qty_sold.AUTHOR_ID, table_with_qty_sold.LAST_NAME, table_with_qty_sold.FIRST_NAME
ORDER BY TOTAL DESC

