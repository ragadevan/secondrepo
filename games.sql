 with t1 as
(select distinct oh.games,oh.noc,region as countrys from olympics_history oh inner join olympics_history_noc_regions hnr
on hnr.noc = oh.noc order by games),
t2 as
(select games,noc,count(medal) as gold_medals from olympics_history
where medal like '%Gold%'
group by noc,games
order by games),
t3 as
(select games,noc,count(medal) as Silver_medals from olympics_history
where medal like '%Silver%'
group by noc,games
order by games),
t4 as
(select games,noc,count(medal) as Bronze_medals from olympics_history
where medal like '%Bronze%'
group by noc,games
order by games),
t5 as
(select t1.games,countrys,gold_medals,Silver_medals,Bronze_medals
from t1 inner join t2 on (t1.noc = t2.noc and t1.games = t2.games)
inner join t3 on (t2.noc = t3.noc and  t2.games = t3.games)
inner join t4 on (t4.noc = t3.noc and  t4.games = t3.games)
order by games,countrys)
select games,max(gold_medals)as max_gold,max(silver_medals) as max_gold,max(bronze_medals) as max_bronze from t5
group by games
order by games