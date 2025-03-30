USE pubs;

-- Challenge 1 - Who Have Published What At Where?
-- In this challenge you will write a MySQL SELECT query that joins various tables to figure out what titles each author 
-- has published at which publishers. Your output should have at least the following columns:

/*
AUTHOR ID - the ID of the author
LAST NAME - author last name
FIRST NAME - author first name
TITLE - name of the published title
PUBLISHER - name of the publisher where the title was published */

SELECT authors.au_id as "AUTHOR ID", authors.au_lname as "LAST NAME", authors.au_fname as "FIRST NAME", 
titles.title as "TITLE" ,publishers.pub_name as "PUBLISHER"
FROM (titleauthor 
		INNER JOIN  authors
		ON titleauthor.au_id = authors.au_id
		INNER JOIN titles 
		ON titleauthor.title_id = titles.title_id
		INNER JOIN publishers
		ON titles.pub_id = publishers.pub_id );

SELECT COUNT(*) AS entry_counts
FROM titleauthor;

SELECT COUNT(*)
FROM (SELECT authors.au_id as "AUTHOR ID", authors.au_lname as "LAST NAME", authors.au_fname as "FIRST NAME", 
titles.title as "TITLE" ,publishers.pub_name as "PUBLISHER"
FROM (titleauthor 
		INNER JOIN  authors
		ON titleauthor.au_id = authors.au_id
		INNER JOIN titles 
		ON titleauthor.title_id = titles.title_id
		INNER JOIN publishers
		ON titles.pub_id = publishers.pub_id ));
        
-- Challenge 2 -- Who Have Published How Many At Where?
-- Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. 

-- Note -- not used DISTINCT in count because it can be published by a different publisher

SELECT authors.au_id as "AUTHOR ID", authors.au_lname as "LAST NAME", authors.au_fname as "FIRST NAME", 
publishers.pub_name as "PUBLISHER", COUNT(titles.title) as "TITLE COUNT"
FROM titleauthor 
		INNER JOIN  authors ON titleauthor.au_id = authors.au_id
		INNER JOIN titles  ON titleauthor.title_id = titles.title_id
		INNER JOIN publishers ON titles.pub_id = publishers.pub_id 
GROUP BY authors.au_id, publishers.pub_name
ORDER BY authors.au_id DESC;

-- Challenge 3 -- Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

SELECT authors.au_id as "AUTHOR ID", authors.au_lname as "LAST NAME", authors.au_fname as "FIRST NAME", 
titles.title as "TITLE" , sales.qty as "TOTAL SALES"
FROM (titleauthor 
		INNER JOIN  authors ON titleauthor.au_id = authors.au_id
		INNER JOIN titles ON titleauthor.title_id = titles.title_id
		INNER JOIN sales ON sales.title_id = titles.title_id )
ORDER BY sales.qty DESC
LIMIT 3;

-- Challenge 4 -- Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3. 
-- Note that the authors who have sold 0 titles should also appear in your output (ideally display 0 instead of NULL as the TOTAL).
 -- Also order your results based on TOTAL from high to low.

SELECT authors.au_id as "AUTHOR ID", authors.au_lname as "LAST NAME", authors.au_fname as "FIRST NAME", 
titles.title as "TITLE" , COALESCE(sales.qty, 0) as "TOTAL SALES"
FROM (titleauthor 
		INNER JOIN  authors ON titleauthor.au_id = authors.au_id
		INNER JOIN titles ON titleauthor.title_id = titles.title_id
		INNER JOIN sales ON sales.title_id = titles.title_id )
ORDER BY sales.qty DESC
LIMIT 23;












