##CHALENGE 1
SELECT
    a.au_id AS `AUTHOR ID`,
    a.au_lname AS `LAST NAME`,
    a.au_fname AS `FIRST NAME`,
    t.title AS `TITLE`,
    p.pub_name AS `PUBLISHER`
FROM authors a
JOIN titleauthor ti ON a.au_id = ti.au_id
JOIN titles t ON ti.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id;

SELECT COUNT(*) FROM titleauthor;


##CHALLENGE 2

SELECT
    a.au_id AS `AUTHOR ID`,
    a.au_lname AS `LAST NAME`,
    a.au_fname AS `FIRST NAME`,
    p.pub_name AS `PUBLISHER`,
    COUNT(*) AS `TITLE COUNT`
FROM authors a
JOIN titleauthor ti ON a.au_id = ti.au_id
JOIN titles t ON ti.title_id = t.title_id
JOIN publishers p ON t.pub_id = p.pub_id
GROUP BY a.au_id, a.au_lname, a.au_fname, p.pub_name
ORDER BY a.au_id, p.pub_name;


##CHALENGE 3 

SELECT
    a.au_id AS `AUTHOR ID`,
    a.au_lname AS `LAST NAME`,
    a.au_fname AS `FIRST NAME`,
    SUM(s.qty) AS `TOTAL`
FROM authors a
JOIN titleauthor ti ON a.au_id = ti.au_id
JOIN sales s ON ti.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY `TOTAL` DESC
LIMIT 3;

##CHALLENGE 4

SELECT
    a.au_id AS `AUTHOR ID`,
    a.au_lname AS `LAST NAME`,
    a.au_fname AS `FIRST NAME`,
    COALESCE(SUM(s.qty), 0) AS `TOTAL`
FROM authors a
JOIN titleauthor ti ON a.au_id = ti.au_id
JOIN sales s ON ti.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY `TOTAL` DESC;


