select*from [laliga21-22]

--Check the missing values for squads
select * from [laliga21-22] 
where squad is null

-- Find the champion
select squad,Pts from [laliga21-22]
order by pts desc

--Find the goal to goal expectation(xG<) of Champion
use kutuphane

alter table [laliga21-22] alter column GF FLOAT

select GF,xG,(GF/xG) as 'Goal to xG Ratio' from [laliga21-22]
where squad= 'Real Madrid'

--Sorting of AVG
Select sum(GF) from [laliga21-22]
Select sum(GF)/COUNT(Squad) as 'Goal per Team' from [laliga21-22]

--find the squads that scored <48 
select squad,GF,
case 
WHEN GF >=48 then 'Above the target' 
else 'Below the target'
end  
from [laliga21-22]
order by gf desc

-- Most agressive teams
alter table [laliga21-22] alter column YC float
alter table [laliga21-22] alter column RC float
alter table [laliga21-22] alter column fouls float
select squad,sum(yc)+sum(rc) as 'Total Cards' from [laliga21-22]
group by squad
order by [Total Cards] desc

select squad,sum(fouls)

select SQUAD,SUM(YC)OVER(partition by squad),ROW_NUMBER() over(order by YC desc) as 'xxx' from [laliga21-22]


select squad,pts, rc,sum(rc) over (partition by squad,pts  ) from [laliga21-22]
order by RC desc,Pts

-- Win to Total Match ratio
alter table [laliga21-22] alter column MP float
alter table [laliga21-22] alter column W float

declare @totalmatch float, @totalwin float, @winratio float
set @totalmatch= (select sum(MP) as 'total match' FROM [laliga21-22])
set @totalwin= (select sum(W) as 'total win' from [laliga21-22]) 
select squad,((W/@totalwin)*100) AS 'wintototalwinratio'   from [laliga21-22]

-- team with most participants
select squad,max([Attendance percent]) over (partition by squad)  from [laliga21-22] 
order by [Attendance percent] desc