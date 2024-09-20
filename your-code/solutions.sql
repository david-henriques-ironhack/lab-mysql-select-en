use pubs;

/* Challenge 1 */

select a.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', t.title as 'TITLE', p.pub_name as 'PUBLISHER'
from authors a
inner join titleauthor ta on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id
inner join publishers p on p.pub_id = t.pub_id;

select count(au_id)
from titleauthor;

/* Challenge 2 */

select a.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', p.pub_name as 'PUBLISHER', count(t.title_id) as 'TITLE COUNT'
from authors a
inner join titleauthor ta on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id
inner join publishers p on p.pub_id = t.pub_id
group by a.au_id, a.au_lname, a.au_fname, p.pub_name;

/* Challenge 3 */

select * from titles;

select a.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', sum(t.ytd_sales) as 'TOTAL'
from authors a
inner join titleauthor ta on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id
group by a.au_id, a.au_lname, a.au_fname
order by TOTAL desc limit 3;

/* Challenge 4 */

select a.au_id as 'AUTHOR ID', a.au_lname as 'LAST NAME', a.au_fname as 'FIRST NAME', ifnull(sum(t.ytd_sales), 0) as 'TOTAL'
from authors a
inner join titleauthor ta on ta.au_id = a.au_id
inner join titles t on ta.title_id = t.title_id
group by a.au_id, a.au_lname, a.au_fname
order by TOTAL desc limit 23;





