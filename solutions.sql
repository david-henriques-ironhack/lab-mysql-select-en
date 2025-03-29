use pubs;

-- Challenge 1 - Who Have Published What At Where?

select authors.au_id as 'AUTHOR ID', authors.au_lname as 'LAST NAME', authors.au_fname as 'FIRST NAME', 
titles.title as TITLE ,publishers.pub_name as PUBLISHER
from titleauthor 
inner join authors
on titleauthor.au_id = authors.au_id
inner join titles 
on titleauthor.title_id = titles.title_id
inner join publishers
on titles.pub_id = publishers.pub_id
order by authors.au_id asc
;


-- Challenge 2 - Who Have Published How Many At Where?
select authors.au_id as 'AUTHOR ID', authors.au_lname as 'LAST NAME', authors.au_fname as 'FIRST NAME', publishers.pub_name as PUBLISHER, max(distinct titles.ytd_sales) as TITLE_COUNT
from titleauthor 
inner join authors
on titleauthor.au_id = authors.au_id
inner join titles 
on titleauthor.title_id = titles.title_id
inner join publishers
on titles.pub_id = publishers.pub_id
group by authors.au_id, authors.au_lname , authors.au_fname, publishers.pub_name
order by authors.au_id desc
;

-- Challenge 3 - Best Selling Authors
select authors.au_id as 'AUTHOR ID', authors.au_lname as 'LAST NAME', authors.au_fname as 'FIRST NAME',  max(sales.qty) as TOTAL
from titleauthor 
inner join authors
on titleauthor.au_id = authors.au_id
inner join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id, authors.au_lname , authors.au_fname, sales.title_id
order by TOTAL desc
limit 3
;

-- Challenge 4 - Best Selling Authors Ranking
select distinct authors.au_id as 'AUTHOR ID', authors.au_lname as 'LAST NAME', authors.au_fname as 'FIRST NAME', coalesce( max(sales.qty),0) as TOTAL
from authors  
inner join titleauthor
on titleauthor.au_id = authors.au_id
left join sales
on titleauthor.title_id = sales.title_id
group by authors.au_id, authors.au_lname , authors.au_fname, sales.title_id
order by TOTAL desc
;