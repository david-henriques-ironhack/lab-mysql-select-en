USE pubs;

/*Challenge 1 - Who Have Published What At Where?*/
SELECT 
	a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    t.title AS 'TITLE',
    p.pub_name AS 'PUBLISHER' 
FROM authors a 
JOIN  titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id =  t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
ORDER BY a.au_id ASC;

/*Challenge 2 - Who Have Published How Many At Where?*/
SELECT 
	a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    t.title AS 'TITLE',
    p.pub_name AS 'PUBLISHER', 
	COUNT(t.title_id) AS 'TITLE COUNT'
FROM authors a 
JOIN  titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id =  t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_id, p.pub_name
ORDER BY a.au_id ASC;

/*Challenge 3 - Best Selling Authors*/
SELECT 
	a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    SUM(s.qty) AS 'TOTAL'
FROM authors a 
JOIN  titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id =  t.title_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY a.au_id
ORDER BY TOTAL DESC
LIMIT 3;

/*Challenge 4 - Best Selling Authors Ranking*/
SELECT 
	a.au_id AS 'AUTHOR ID',
    a.au_lname AS 'LAST NAME',
    a.au_fname AS 'FIRST NAME',
    COALESCE(SUM(s.qty),0) AS 'TOTAL'
FROM authors a 
JOIN  titleauthor ta ON a.au_id = ta.au_id
JOIN titles t ON ta.title_id =  t.title_id
JOIN sales s ON t.title_id = s.title_id
GROUP BY a.au_id
ORDER BY TOTAL DESC;
