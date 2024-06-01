-- Phan Van Hoang
-- 22280033
-- PostgreSQL

-- Cau 1
SELECT r.refereeid ,r.fname ,r.mname ,r.lname 
FROM referee r 
JOIN contract c ON r.contractid = c.contractid 
WHERE c.salary > 50000000;

-- Cau 2
SELECT *
FROM game 
JOIN team ON game.hometeam = team.teamname OR game.awayteam = team.teamname
WHERE team.city = 'Madrid' AND EXTRACT (YEAR FROM game.mdate) = 2016 AND EXTRACT (MONTH FROM game.mdate) = 4;

-- Cau 3
SELECT *
FROM officiates o 
JOIN game g ON o.gameid = g.gameid 
JOIN referee r ON o.refereeid = r.refereeid 
WHERE r.fname = 'Matt' AND r.lname = 'Ross'
ORDER BY g.mdate ;

-- Cau 4
SELECT team.teamname, count(team.teamname) AS tong_so_tran_thi_dau
FROM game 
JOIN team ON game.hometeam = team.teamname OR game.awayteam = team.teamname
GROUP BY team.teamname ;

-- Cau 5
SELECT t.teamname, count(t.teamname) AS tong_so_cau_thu, sum(s.redcards) AS tong_the_do, sum(s.yellowcards) AS tong_the_vang, sum(s.goals) AS tong_ban_thang
FROM team t 
JOIN player p ON t.teamname = p.teamname 
JOIN stats s ON p.playerid = s.playerid 
GROUP BY t.teamname 
HAVING sum(s.goals) > 20;

-- Cau 6
SELECT p.fname ,p.mname ,p.lname ,count(g.hometeam) AS so_tran_san_nha
FROM player p 
JOIN team t ON p.teamname = t.teamname 
JOIN game g ON t.teamname = g.hometeam OR t.teamname = g.awayteam 
WHERE p.teamname = 'Chelsea' 
GROUP BY p.fname ,p.mname ,p.lname;

-- Cau 7
SELECT t.teamname ,t.points 
FROM team t 
JOIN player p ON t.teamname  = p.teamname 
WHERE t.teamname in (
   SELECT t.teamname
   FROM team t 
   JOIN player p ON t.teamname  = p.teamname
   WHERE EXTRACT(YEAR FROM p.birthday) < 1990)
GROUP BY t.teamname ,t.points
HAVING count(t.teamname) < 2;

-- Cau 8
SELECT p.fname ,p.mname ,p.lname, p.nationality ,p.teamname 
FROM goal g 
JOIN player p ON g.playerid = p.playerid 
ORDER BY p.nationality ;

-- Cau 9
SELECT p.fname ,p.mname ,p.lname 
FROM player p 
JOIN team t ON p.teamname = t.teamname 
JOIN game g ON t.teamname = g.hometeam OR t.teamname = g.awayteam 
WHERE EXTRACT (YEAR FROM g.mdate) = 2016 AND EXTRACT (MONTH FROM g.mdate) = 4;
GROUP BY p.fname ,p.mname ,p.lname ;

-- Cau 10
with TEAM_GAME(TeamName, Tongdiem, Tongtran) as (
   select T.TeamName, sum(Points), count(G.GameID) 
   from TEAM as T join GAME as G on T.TeamName=G.AwayTeam or T.TeamName=G.HomeTeam
   group by T.TeamName
)
select PL.TeamName,Tongdiem, Tongtran, sum(Goals) as 'Tong ban thang', sum(YellowCards) as 'Tong the vang', sum(RedCards) as 'Tong the do'
from PLAYER as PL join STATS as STS on PL.PlayerID=STS.PlayerID 
join TEAM_GAME on PL.TeamName=TEAM_GAME.TeamName
group by PL.TeamName,Tongdiem, Tongtran;

