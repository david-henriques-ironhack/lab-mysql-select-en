# Challenge 1
SELECT 
	authors.au_id as AUTHOR_ID,
    authors.au_lname as LAST_NAME,
    authors.au_fname as FIRST_NAME,
    titles.title as TITLE,
    publishers.pub_name as PUBLISHER
    
FROM authors 
JOIN
	titleauthor ON
    titleauthor.au_id = authors.au_id
JOIN
	titles ON
	titleauthor.title_id = titles.title_id 
JOIN
	publishers ON
    titles.pub_id  = publishers.pub_id
    
# Challenge 2

SELECT 
	author_id,
    last_name,
    first_name,
    publisher,
    COUNT(title) as total_published
FROM (
SELECT 
	authors.au_id as AUTHOR_ID,
    authors.au_lname as LAST_NAME,
    authors.au_fname as FIRST_NAME,
    titles.title as TITLE,
    publishers.pub_name as PUBLISHER
    
FROM authors 
JOIN
	titleauthor ON
    titleauthor.au_id = authors.au_id
JOIN
	titles ON
	titleauthor.title_id = titles.title_id 
JOIN
	publishers ON
    titles.pub_id  = publishers.pub_id
) as books_data
GROUP BY
	author_id,
    last_name,
    first_name,
    publisher
ORDER BY 
	total_published DESC
    
# Checking output
SELECT 
	SUM(total_published)
FROM(
SELECT 
	author_id,
    last_name,
    first_name,
    publisher,
    COUNT(title) as total_published
FROM (
SELECT 
	authors.au_id as AUTHOR_ID,
    authors.au_lname as LAST_NAME,
    authors.au_fname as FIRST_NAME,
    titles.title as TITLE,
    publishers.pub_name as PUBLISHER
    
FROM authors 
JOIN
	titleauthor ON
    titleauthor.au_id = authors.au_id
JOIN
	titles ON
	titleauthor.title_id = titles.title_id 
JOIN
	publishers ON
    titles.pub_id  = publishers.pub_id
) as books_data
GROUP BY
	author_id,
    last_name,
    first_name,
    publisher
ORDER BY 
	total_published DESC
) as books_count

SELECT COUNT(title_id)
FROM titleauthor
	
    
# Challenge 3
SELECT 
	authors.au_id,
    au_lname,
    au_fname,
    COUNT(title_id) as titles_sold
FROM authors
LEFT JOIN
	titleauthor ON titleauthor.au_id = authors.au_id
GROUP BY
	authors.au_id,
    au_lname,
    au_fname
ORDER BY
	titles_sold DESC
LIMIT 3

# Challenge 4
SELECT 
	authors.au_id,
    au_lname,
    au_fname,
    COUNT(title_id) as titles_sold
FROM authors
LEFT JOIN
	titleauthor ON titleauthor.au_id = authors.au_id
GROUP BY
	authors.au_id,
    au_lname,
    au_fname
ORDER BY
	titles_sold DESC
	



