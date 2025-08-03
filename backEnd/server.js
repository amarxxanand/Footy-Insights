import express from 'express';
import mysql from 'mysql'

import cors from 'cors';

const app = express();


const db = mysql.createConnection({
    host: "localhost",
    user: 'amar',
    password: 'root',
    database: 'football'


})

app.use(cors());

db.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the database.');
});


// Query handler
app.post('/api/query', (req, res) => {
    const { queryId, filters } = req.body;

    let sql = '';
    switch (queryId) {
        case '1':
            sql = `SELECT club_name, COUNT(player_id) AS num_players, AVG(age) AS avg_age
FROM player
GROUP BY club_name
ORDER BY avg_age DESC`;
            break;
        case '2':
            sql = `SELECT p.club_name, SUM(ps.goals) AS total_goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY total_goals DESC`;
            break;
        case '3':
            sql = `SELECT player_name, goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.goals DESC
LIMIT 5`;
            break;
        case '4':
            sql = `SELECT p.player_name, ps.assists
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.assists DESC
LIMIT 5`;
            break;
        case '5':
            sql = `SELECT p.nationality, COUNT(p.player_id) AS num_players, SUM(ps.goals) AS total_goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.nationality
ORDER BY total_goals DESC`;
            break;

        case '6':
            sql = `SELECT p.player_id, p.player_name, ps.percentage_passes_completed
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
WHERE ps.percentage_passes_completed > (
    SELECT AVG(percentage_passes_completed) FROM player_stats
)
ORDER BY ps.percentage_passes_completed DESC`;
            break;
        case '7':
            sql = `SELECT winner AS club, COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY wins DESC`;
            break;
        case '8':
            sql = `SELECT p.club_name, AVG(ps.assists) AS avg_assists
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY avg_assists DESC`;
            break;
        case '9':
            sql = `SELECT DISTINCT club_name
FROM player
WHERE age > (SELECT AVG(age) FROM player)`;
            break;
        case '10':
            sql = `SELECT p.player_id, p.player_name, ps.goals
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
WHERE ps.goals > (SELECT AVG(goals) FROM player_stats)
ORDER BY ps.goals DESC`;
            break;
        case '11':
            sql = `SELECT p.player_id, p.player_name, COUNT(pm.match_id) AS matches_played
FROM player p
JOIN player_matches pm ON p.player_id = pm.player_id
GROUP BY p.player_id, p.player_name
ORDER BY matches_played DESC`;
            break;
        case '12':
            sql = `SELECT p.player_id, p.player_name, p.club_name, ps.goals, ps.assists, p.nationality
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
ORDER BY ps.goals DESC, ps.assists`;
            break;
        case '13':
            sql = `SELECT match_id, home_team, away_team, (home_team_goals + away_team_goals) AS total_goals
FROM matches
ORDER BY total_goals DESC`;
            break;
        case '14':
            sql = `SELECT p.club_name, AVG(ps.percentage_passes_completed) AS avg_pass_completion
FROM player p
JOIN player_stats ps ON p.player_id = ps.player_id
GROUP BY p.club_name
ORDER BY avg_pass_completion DESC
LIMIT 1`;
            break;
        case '15':
            sql = `SELECT DISTINCT p.player_name, p.club_name
FROM player p
JOIN matches m ON p.club_name = m.winner
ORDER BY p.club_name, p.player_name`;
            break;

        default:
            return res.status(400).json({ error: 'Invalid query ID' });
    }

    // Execute the query
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error executing query:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});




// Endpoint to fetch clubs
app.get('/api/clubs', (req, res) => {
    const sql = `SELECT DISTINCT club_name FROM player ORDER BY club_name ASC`;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching clubs:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results.map(row => row.club_name));
    });
});

// Endpoint to fetch players
app.get('/api/players', (req, res) => {
    const sql = `SELECT DISTINCT player_name FROM player ORDER BY player_name ASC`;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching players:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results.map(row => row.player_name));
    });
});

// Endpoint to fetch countries
app.get('/api/countries', (req, res) => {
    const sql = `SELECT DISTINCT nationality FROM player ORDER BY nationality ASC`;
    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching countries:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results.map(row => row.nationality));
    });
});

//QUERY 1
// Endpoint to fetch data for Query 1
app.get('/api/query1', (req, res) => {


    const { club } = req.query; // Get the club filter from the query parameters
    console.log('Club filter received:', club); // Log the received club filter
    let sql = `
        SELECT club_name, COUNT(player_id) AS num_players, AVG(age) AS avg_age
        FROM player
    `;

    // Apply the club filter if provided
    if (club && club !== 'all') {
        sql += ` WHERE club_name = '${club}'`;
    }

    sql += ` GROUP BY club_name ORDER BY avg_age DESC`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 1 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});



// Endpoint to fetch data for Query 2 with club filter
app.get('/api/query2', (req, res) => {
    const { club } = req.query; // Get the club filter from the query parameters
    console.log('Club filter received for Query 2:', club); // Log the received club filter

    let sql = `
        SELECT p.club_name, SUM(ps.goals) AS total_goals
        FROM player p
        JOIN player_stats ps ON p.player_id = ps.player_id
    `;

    // Apply the club filter if provided
    if (club && club !== 'all') {
        sql += ` WHERE p.club_name = ?`;
    }

    sql += ` GROUP BY p.club_name ORDER BY total_goals DESC`;

    console.log('Executing SQL query for Query 2:', sql, club && club !== 'all' ? [club] : []); // Log the SQL query

    db.query(sql, club && club !== 'all' ? [club] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 2 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});



//QUERY 3
// Endpoint to fetch data for Query 3
app.get('/api/query3', (req, res) => {
    const sql = `
        SELECT player_name, goals
        FROM player p
        JOIN player_stats ps ON p.player_id = ps.player_id
        ORDER BY ps.goals DESC
        LIMIT 5
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 3 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 4
// Endpoint to fetch data for Query 4
app.get('/api/query4', (req, res) => {
    const sql = `
        SELECT p.player_name, ps.assists
        FROM player p
        JOIN player_stats ps ON p.player_id = ps.player_id
        ORDER BY ps.assists DESC
        LIMIT 5
    `;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 4 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});


//QUERY 5
// Endpoint to fetch data for Query 5 with nationality filter
app.get('/api/query5', (req, res) => {
    const { nationality } = req.query; // Get the nationality filter from the query parameters
    console.log('Nationality filter received for Query 5:', nationality); // Log the received nationality filter

    let sql = `
        SELECT p.nationality, COUNT(p.player_id) AS num_players, SUM(ps.goals) AS total_goals
        FROM player p
        JOIN player_stats ps ON p.player_id = ps.player_id
    `;

    // Apply the nationality filter if provided
    if (nationality && nationality !== 'all') {
        sql += ` WHERE p.nationality = ?`;
    }

    sql += ` GROUP BY p.nationality ORDER BY total_goals DESC`;

    console.log('Executing SQL query for Query 5:', sql, nationality && nationality !== 'all' ? [nationality] : []); // Log the SQL query

    db.query(sql, nationality && nationality !== 'all' ? [nationality] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 5 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});

//QUERY 6
// Endpoint to fetch data for Query 6
app.get('/api/query6', (req, res) => {
    const sql = `SELECT p.player_id, p.player_name, ps.percentage_passes_completed
    FROM player p
    JOIN player_stats ps ON p.player_id = ps.player_id
    WHERE ps.percentage_passes_completed > (
        SELECT AVG(percentage_passes_completed) FROM player_stats
    )
    ORDER BY ps.percentage_passes_completed DESC`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 6 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});

//QUERY 7
// Endpoint to fetch data for Query 7

app.get('/api/query7', (req, res) => {
    const { club } = req.query; // Get the club filter from the query parameters
    console.log('Club filter received for Query 7:', club); // Log the received club filter

    let sql = `SELECT winner AS club, COUNT(*) AS wins
    FROM matches
    WHERE winner IS NOT NULL`;

    // Apply the club filter if provided
    if (club && club !== 'all') {
        sql += ` AND winner = ?`;
    }

    sql += ` GROUP BY winner ORDER BY wins DESC`;
    console.log('Executing SQL query for Query 7:', sql); // Log the SQL query

    db.query(sql, club && club !== 'all' ? [club] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 7 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});


app.get('/api/query8', (req, res) => {
    const { club } = req.query; // Get the club filter from the query parameters
    console.log('Club filter received for Query 8:', club); // Log the received club filter

    let sql = `SELECT p.club_name, AVG(ps.assists) AS avg_assists
    FROM player p
    JOIN player_stats ps ON p.player_id = ps.player_id`;

    // Apply the club filter if provided
    if (club && club !== 'all') {
        sql += ` WHERE p.club_name = ?`;
    }

    sql += ` GROUP BY p.club_name ORDER BY avg_assists DESC`;
    console.log('Executing SQL query for Query 8:', sql); // Log the SQL query

    db.query(sql, club && club !== 'all' ? [club] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 8 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 9   
// Endpoint to fetch data for Query 9
app.get('/api/query9', (req, res) => {
    const sql = `SELECT DISTINCT club_name
    FROM player
    WHERE age > (SELECT AVG(age) FROM player)`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 9 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 10
// Endpoint to fetch data for Query 10
app.get('/api/query10', (req, res) => {
    const sql = `SELECT p.player_id, p.player_name, ps.goals
    FROM player p
    JOIN player_stats ps ON p.player_id = ps.player_id
    WHERE ps.goals > (SELECT AVG(goals) FROM player_stats)
    ORDER BY ps.goals DESC`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 10 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 11
// Endpoint to fetch data for Query 11
app.get('/api/query11', (req, res) => {

    const { player } = req.query; // Get the player filter from the query parameters
    console.log('Player filter received for Query 11:', player); // Log the received player filter

    // const sql = `SELECT p.player_id, p.player_name, COUNT(pm.match_id) AS matches_played
    // FROM player p
    // JOIN player_matches pm ON p.player_id = pm.player_id
    // GROUP BY p.player_id, p.player_name
    // ORDER BY matches_played DESC`;

    let sql = `SELECT p.player_id, p.player_name, COUNT(pm.match_id) AS matches_played
    FROM player p
    JOIN player_matches pm ON p.player_id = pm.player_id`;
    // Apply the player filter if provided
    if (player && player !== 'all') {
        sql += ` WHERE p.player_name = ?`;
    }
    sql += ` GROUP BY p.player_id, p.player_name
    ORDER BY matches_played DESC`;
    console.log('Executing SQL query for Query 11:', sql); // Log the SQL query

    db.query(sql, player && player !== 'all' ? [player] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 11 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 12
// Endpoint to fetch data for Query 12
app.get('/api/query12', (req, res) => {


    // const sql = `SELECT p.player_id, p.player_name, p.club_name, ps.goals, ps.assists, p.nationality
    //     FROM player p
    //     JOIN player_stats ps ON p.player_id = ps.player_id
    //     ORDER BY ps.goals DESC, ps.assists`;

    const { player } = req.query; // Get the player filter from the query parameters
    console.log('Player filter received for Query 12:', player); // Log the received player filter

    let sql = `SELECT p.player_id, p.player_name, p.club_name, ps.goals, ps.assists, p.nationality
    FROM player p
    JOIN player_stats ps ON p.player_id = ps.player_id`;
    // Apply the player filter if provided
    if (player && player !== 'all') {
        sql += ` WHERE p.player_name = ?`;
    }
    sql += ` ORDER BY ps.goals DESC, ps.assists`;
    console.log('Executing SQL query for Query 12:', sql); // Log the SQL query
    // Execute the query
    db.query(sql, player && player !== 'all' ? [player] : [], (err, results) => {
        if (err) {
            console.error('Error fetching Query 12 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });




}
);
//QUERY 13
// Endpoint to fetch data for Query 13
app.get('/api/query13', (req, res) => {
    const sql = `SELECT match_id, home_team, away_team, (home_team_goals + away_team_goals) AS total_goals
    FROM matches
    ORDER BY total_goals DESC`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 13 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    }
    );
}
);
//QUERY 14
// Endpoint to fetch data for Query 14
app.get('/api/query14', (req, res) => {
    const sql = `SELECT p.club_name, AVG(ps.percentage_passes_completed) AS avg_pass_completion
    FROM player p
    JOIN player_stats ps ON p.player_id = ps.player_id
    GROUP BY p.club_name
    ORDER BY avg_pass_completion DESC
    LIMIT 1`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 14 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
//QUERY 15
// Endpoint to fetch data for Query 15
app.get('/api/query15', (req, res) => {
    const sql = `SELECT DISTINCT p.player_name, p.club_name
    FROM player p
    JOIN matches m ON p.club_name = m.winner
    ORDER BY p.club_name, p.player_name`;

    db.query(sql, (err, results) => {
        if (err) {
            console.error('Error fetching Query 15 data:', err);
            return res.status(500).json({ error: 'Database error' });
        }
        res.json(results);
    });
});
// Middleware to parse JSON request bodies
app.use(express.json());
// Middleware to handle CORS
app.use(cors());
// Middleware to serve static files (if needed)
app.use(express.static('public'));
// Middleware to handle errors
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Start the server
const PORT = 5000;
app.listen(PORT, () => {
    console.log(`connected to backend.`);
});