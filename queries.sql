-- 1. List each club with the count of players and their average age.
SELECT club_name, COUNT(player_id) AS num_players, AVG(age) AS avg_age
FROM player
GROUP BY club_name
ORDER BY avg_age DESC;

-- 2. Get the total number of goals scored by players per club using player_stats.
SELECT p.club_name, SUM(ps.goals) AS total_goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY total_goals DESC;

-- 3. Find the top 5 players with the highest number of goals.
SELECT player_name, goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.goals DESC
LIMIT 5;

-- 4. Find the top 5 players with the most assists.
SELECT p.player_name, ps.assists
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.assists DESC
LIMIT 5;

-- 5. Aggregate players by nationality: count players and total goals scored per nationality.
SELECT p.nationality, COUNT(p.player_id) AS num_players, SUM(ps.goals) AS total_goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.nationality
ORDER BY total_goals DESC;

-- 6. Find players whose pass completion percentage is above the overall average.
SELECT p.player_id, p.player_name, ps.percentage_passes_completed
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
WHERE ps.percentage_passes_completed > (
    SELECT AVG(percentage_passes_completed) FROM player_stats
)
ORDER BY ps.percentage_passes_completed DESC;

-- 7. Count the number of wins per club
SELECT winner AS club, COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY wins DESC;

-- 8. Calculate the average number of assists made by players for each club.
SELECT p.club_name, AVG(ps.assists) AS avg_assists
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY avg_assists DESC;

-- 9. List clubs that have at least one player older than the overall average age.
SELECT DISTINCT club_name
FROM player
WHERE age > (SELECT AVG(age) FROM player);

-- 10. Find players who have scored above the overall average number of goals.
SELECT p.player_id, p.player_name, ps.goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
WHERE ps.goals > (SELECT AVG(goals) FROM player_stats)
ORDER BY ps.goals DESC;

-- 11. List each player along with the number of matches they played.
SELECT p.player_id, p.player_name, COUNT(pm.match_id) AS matches_played
FROM player p
JOIN player_matches pm ON p.player_id = pm.player_id
GROUP BY p.player_id, p.player_name
ORDER BY matches_played DESC;

-- 12. List each player with their goal and assist totals along with their own nationality.
SELECT p.player_id, p.player_name, p.club_name, ps.goals, ps.assists, p.nationality
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.goals DESC, ps.assists;

-- 13. List each match along with the total goals scored (home plus away).
SELECT match_id, home_team, away_team, (home_team_goals + away_team_goals) AS total_goals
FROM matches
ORDER BY total_goals DESC;

-- 14. Find the club with the highest average pass completion percentage among its players.
SELECT p.club_name, AVG(ps.percentage_passes_completed) AS avg_pass_completion
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY avg_pass_completion DESC
LIMIT 1;

-- 15. List the names of players whose clubs have won at least one match.
SELECT DISTINCT p.player_name, p.club_name
FROM player p
JOIN matches m ON p.club_name = m.winner
ORDER BY p.club_name, p.player_name;