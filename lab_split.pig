visits = load 'whitehouse/' using PigStorage(',');
/*
not_null_25 = FILTER visits BY ($25 IS NOT NULL);
comments = foreach not_null_25 GENERATE $25 as comment;
comments_sample = SAMPLE comments 0.00001;
dump comments_sample;

comments_all = GROUP comments ALL;
comments_count = foreach comments_all GENERATE COUNT(comments);
dump comments_count;
*/

split visits into congress if($25 matches '.* CONGRESS .*'),
not_congress if(NOT($25 MATCHES '.* CONGRESS .*'));
-- store congress into 'congress';
-- store not_congress into 'not_congress';

congress_grp = group congress ALL;
congress_count = foreach congress_grp GENERATE COUNT(congress_grp);

not_congress_grp = group not_congress ALL;
not_congress_count = foreach not_congress_grp GENERATE COUNT(not_congress_grp);

dump congress_count;
dump not_congress_count;
