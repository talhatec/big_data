--join.pig joins congre and visits

visitors = load 'whitehouse/visits.txt' using PigStorage(',') as
(lname:chararray, fname:chararray);

congress = load 'whitehouse/congress.txt' as 
(
	full_title:chararray,
	district:chararray,
	title:chararray,
	fname:chararray,
	lname:chararray,
	party:chararray
);

congress_data = foreach congress GENERATE
 district,
 UPPER(lname) as lname,
 UPPER(fname) as fname,
 party;

join_contact_congress = JOIN visitors by (lname,fname), congress_data by (lname,fname) using 'replicated';

store join_contact_congress into 'joinresult';

