


--Challenge 1 - Who Have Published What At Where?
SELECT
	authors.au_id AS "AUTHOR ID",
	au_lname AS "LAST NAME",
	au_fname AS "FIRST NAME",
    titles.title AS "TITLE",
    publishers.pub_name AS "PUBLISHER"
FROM pubs.authors
LEFT JOIN
pubs.titleauthor
	ON authors.au_id = titleauthor.au_id
LEFT JOIN
titles
ON	titleauthor.title_id = titles.title_id
LEFT JOIN
publishers
ON titles.pub_id = publishers.pub_id
WHERE titles.title IS NOT NULL
;



--Challenge 2 - Who Have Published What At Where?
SELECT
	authors.au_id AS "AUTHOR ID",
	au_lname AS "LAST NAME",
	au_fname AS "FIRST NAME",
    publishers.pub_name AS "PUBLISHER",
    COUNT(DISTINCT titles.title) AS "TITLE COUNT"
FROM pubs.authors
LEFT JOIN
pubs.titleauthor
	ON authors.au_id = titleauthor.au_id
LEFT JOIN
titles
ON	titleauthor.title_id = titles.title_id
LEFT JOIN
publishers
ON titles.pub_id = publishers.pub_id
WHERE titles.title IS NOT NULL
GROUP BY 1,2,3,4
;


-- To check if your output is correct, sum up the `TITLE COUNT` column. The sum number should be the same as the total number of records in Table `titleauthor`.
SELECT
    COUNT(titles.title) AS "TOTAL TITLE COUNT"
FROM pubs.authors
LEFT JOIN
    pubs.titleauthor
    ON authors.au_id = titleauthor.au_id
LEFT JOIN
    pubs.titles
    ON titleauthor.title_id = titles.title_id
LEFT JOIN
    pubs.publishers
    ON titles.pub_id = publishers.pub_id
WHERE titles.title IS NOT NULL;

SELECTCOUNT(*) AS total_count
FROM pubs.titleauthor
WHERE title_id IS NOT NULL;



-- Challenge 3 - TOP 3 Best selling authors
SELECT
	authors.au_id AS "AUTHOR ID",
	au_lname AS "LAST NAME",
	au_fname AS "FIRST NAME",
    COUNT(DISTINCT sales.qty) AS "TITLE COUNT"
FROM pubs.authors
LEFT JOIN
pubs.titleauthor
	ON authors.au_id = titleauthor.au_id
LEFT JOIN
pubs.titles
ON	titleauthor.title_id = titles.title_id
LEFT JOIN
pubs.sales
ON titles.title_id = sales.title_id
WHERE titles.title IS NOT NULL
GROUP BY 1,2,3
ORDER BY COUNT(DISTINCT sales.qty) DESC
LIMIT 3
;

-- Challenge 4 - Best Selling Authors Ranking
SELECT
	authors.au_id AS "AUTHOR ID",
	au_lname AS "LAST NAME",
	au_fname AS "FIRST NAME",
    COUNT(DISTINCT sales.qty) AS "TITLE COUNT"
FROM pubs.authors
LEFT JOIN
pubs.titleauthor
	ON authors.au_id = titleauthor.au_id
LEFT JOIN
pubs.titles
ON	titleauthor.title_id = titles.title_id
LEFT JOIN
pubs.sales
ON titles.title_id = sales.title_id
GROUP BY 1,2,3
ORDER BY COUNT(DISTINCT sales.qty) DESC
;

