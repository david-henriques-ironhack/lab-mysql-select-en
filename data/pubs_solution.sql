USE pubs;

-- Challenge 1: Who Have Published What At Where?
SELECT   -- Select the required columns: author ID, last name, first name, title name, and publisher name
  authors.au_id AS 'AUTHOR ID',   -- ID of the author
  authors.au_lname AS 'LAST NAME',  -- Author's last name
  authors.au_fname AS 'FIRST NAME',  -- Author's first name
  titles.title AS 'TITLE',   -- Title of the book
  publishers.pub_name AS 'PUBLISHER'  -- Name of the publisher
FROM titleauthor 
JOIN authors ON titleauthor.au_id = authors.au_id  -- Join authors table to get author details
JOIN titles ON titleauthor.title_id = titles.title_id -- Join titles table to get title details
JOIN publishers ON titles.pub_id = publishers.pub_id;  -- Join publishers table to get publisher name

SELECT COUNT(*) FROM titleauthor; -- Check number of rows to validate correctness

-- Challenge 2: Who Have Published How Many At Where?
SELECT
  authors.au_id AS 'AUTHOR ID',           -- Author ID
  authors.au_lname AS 'LAST NAME',        -- Author's last name
  authors.au_fname AS 'FIRST NAME',       -- Author's first name
  publishers.pub_name AS 'PUBLISHER',     -- Publisher's name
  COUNT(*) AS 'TITLE COUNT'               -- Count how many titles each author has published at each publisher
FROM titleauthor
JOIN authors ON titleauthor.au_id = authors.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
JOIN publishers ON titles.pub_id = publishers.pub_id
GROUP BY authors.au_id, publishers.pub_name
ORDER BY authors.au_id, publishers.pub_name;

-- Challenge 3: Best Selling Authors
SELECT
  authors.au_id AS 'AUTHOR ID',    -- Author ID
  authors.au_lname AS 'LAST NAME',  -- Author's last name
  authors.au_fname AS 'FIRST NAME',   -- Author's first name
  SUM(titles.ytd_sales) AS 'TOTAL'  -- Total number of copies sold (sum of ytd_sales)
FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id    -- Link authors to titleauthor
JOIN titles ON titleauthor.title_id = titles.title_id   -- Link titles to get sales
GROUP BY authors.au_id, authors.au_lname, authors.au_fname   -- Group by author
ORDER BY TOTAL DESC       -- Order by total sales (highest first)
LIMIT 3;        -- Get the top 3 authors who have sold the highest number of titles


-- Challenge 4: Best Selling Authors Ranking: Show all authors with their total book sales, even if they sold zero titles
SELECT
  authors.au_id AS 'AUTHOR ID',      -- Author ID
  authors.au_lname AS 'LAST NAME',   -- Author's last name
  authors.au_fname AS 'FIRST NAME',    -- Author's first name
  IFNULL(SUM(titles.ytd_sales), 0) AS 'TOTAL'   -- Total sales (0 if the author has no sales)
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id  -- Keep all authors, even if no titles
LEFT JOIN titles ON titleauthor.title_id = titles.title_id    -- Join to get sales info (if any)
GROUP BY authors.au_id, authors.au_lname, authors.au_fname  -- Group by author
ORDER BY TOTAL DESC;  -- Order from highest to lowest sales
