import express from 'express'; //alottaa mun express sovelluksen
import pkg from 'pg';
const { Pool } = pkg;  //pool on database yhteyksiä varten.

const app = express();

// mihin porttiin localhost tehdään.
const port = process.env.PORT || 3001;  //jos porttia ei määritellä default on 3001

// määritellään database configuraatio
const pool = new Pool({
    user: 'postgres',         // Your database username
    host: '127.0.0.1',        // Host of your database
    database: 'postgres',     // Database name
    password: 'Sandels',         // Database password
    port: 5432,               // PostgreSQL port
});

app.use(express.json()); //jos ei ole tätä niin ei voi lukea req komentoja

// alotetaan serveri
app.listen(port, () => {
    console.log(`The server is running on port ${port}!!`);  //lukee riviltä 8 tiedon const = port osaa lukea 3001
});

// Root endpoint
app.get('/', (req, res) => {
    res.send('You just called the root endpoint!!');  //Req kuvaa tulevaa tietoa / pyyntöä. res kuvaa serverin lähettämää vastausta.
});

// GET Endpoint käsitellään user ID
app.get('/users/:id', async (req, res) => {
    const userid = req.params.id; // Get user ID from the URL
    console.log(`User ID received: ${userid}`);  // Logs the received user ID
    
    try {
        // Use the exact case-sensitive name for the column
        const result = await pool.query('SELECT * FROM "users" WHERE "userid" = $1', [userid]);
        if (result.rows.length > 0) {
            res.json({ message: 'done', users: result.rows[0] });
        } else {
            res.status(404).json({ error: 'User not found' });  // If no user is found, return 404
        }
    } catch (error) {
        res.status(500).json({ error: 'Database query failed', details: error.message }); // Return 500 on error
    }
});

app.get('/movie/:movieid', async (req, res) => {
    const movieid = req.params.movieid;
    console.log(`Movie id received:) ${movieid}`);
try {
    // Use the exact case-sensitive name for the column
    const result = await pool.query('SELECT * FROM "movie" WHERE "movieid" = $1', [movieid]);

    if (result.rows.length > 0) {
        res.json({ message: 'done', movie: result.rows[0] });
    } else {
        res.status(404).json({ error: 'movie not found' });  // If no movie is found, return 404
    }
} catch (error) {
    res.status(500).json({ error: 'Database query failed', details: error.message }); // Return 500 on error
}
});

app.get('/genre/:genreid', async (req, res) => {
    const genreid = req.params.genreid;
    console.log(`Movie id received:) ${genreid}`);
try {
    // Use the exact case-sensitive name for the column
    const result = await pool.query('SELECT * FROM "genre" WHERE "genreid" = $1', [genreid]);
    
    if (result.rows.length > 0) {
        res.json({ message: 'done', genre: result.rows[0] });
    } else {
        res.status(404).json({ error: 'genre not found' });  // If no movie is found, return 404
    }
} catch (error) {
    res.status(500).json({ error: 'Database query failed', details: error.message }); // Return 500 on error
}
});

app.get('/favorite/:favoriteid', async (req, res) => {
    const favoriteid = req.params.favoriteid;
    console.log(`Favorite ID received: ${favoriteid}`);
    
    try {
        // Use the lowercase table and column names
        const result = await pool.query('SELECT * FROM "favorite" WHERE "favoriteid" = $1', [favoriteid]);
        
        if (result.rows.length > 0) {
            res.json({ message: 'done', favorite: result.rows[0] });
        } else {
            res.status(404).json({ error: 'Favorite not found' });  // If no favorite is found, return 404
        }
    } catch (error) {
        res.status(500).json({ error: 'Database query failed', details: error.message }); // Return 500 on error
    }
});

app.get('/review/:reviewid', async (req, res) => {
    const reviewid = req.params.reviewid;
    console.log(`Review ID received: ${reviewid}`);
    
    try {
        // Use the lowercase table and column names
        const result = await pool.query('SELECT * FROM "review" WHERE "reviewid" = $1', [reviewid]);
        
        if (result.rows.length > 0) {
            res.json({ message: 'done', reviewid: result.rows[0] });
        } else {
            res.status(404).json({ error: 'Review not found' });  // If no favorite is found, return 404
        }
    } catch (error) {
        res.status(500).json({ error: 'Database query failed', details: error.message }); // Return 500 on error
    }
});

app.post('/movie', async (req, res) => {
    // Ota vastaan elokuvan tiedot pyynnön rungosta
    const { movieid, genreid, moviename, movieyear } = req.body;

    try {
        // Lisää uusi elokuva tietokantaan
        const result = await pool.query(
            `INSERT INTO "movie" ("movieid", "genreid", "moviename", "movieyear") 
            VALUES ($1, $2, $3, $4) RETURNING *`,
            [movieid, genreid, moviename, movieyear]
        );

        // Palauta onnistumisviesti ja lisätty elokuva
        res.status(201).json({ 
            message: 'Movie added successfully!', 
            movie: result.rows[0] 
        });
    } catch (error) {
        // Käsittele virheet
        console.error('Error adding movie:', error.message);
        res.status(500).json({ 
            error: 'Failed to add movie', 
            details: error.message 
        });
    }
})

// DELETE-reitti elokuvan poistamiseen movieid:n perusteella
app.delete('/movie/:movieid', async (req, res) => {
    const movieid = req.params.movieid; // Poimitaan movieid URL:sta

    try {
        // Suoritetaan DELETE-kysely tietokannassa
        const result = await pool.query('DELETE FROM "movie" WHERE "movieid" = $1 RETURNING *', [movieid]);

        if (result.rowCount > 0) {
            // Jos elokuva löytyi ja poistettiin
            res.json({
                message: 'Movie deleted successfully!',
                deletedMovie: result.rows[0] // Palautetaan poistettu elokuva vastauksessa
            });
        } else {
            // Jos elokuvaa ei löytynyt
            res.status(404).json({ error: 'Movie not found' });
        }
    } catch (error) {
        // Jos tapahtui virhe
        console.error('Error deleting movie:', error.message);
        res.status(500).json({ 
            error: 'Failed to delete movie', 
            details: error.message 
        });
    }
});





