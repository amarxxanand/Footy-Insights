import React, { useState, useEffect } from 'react';
import './Football.css';

const queries = {
    "1": {
        title: "List each club with the count of players and their average age",
        description: "Displays each club along with their player count and average age.",
        filters: ["club"]
    },
    "2": {
        title: "Total number of goals scored by players per club",
        description: "Aggregates total goals from the player_stats table per club. Use the club filter to view results for a specific club.",
        filters: ["club"]
    },
    "3": {
        title: "Top 5 players with the highest number of goals",
        description: "Displays the top five players based on their goal count.",
        filters: []
    },
    "4": {
        title: "Top 5 players with the most assists",
        description: "Displays the top five players based on assist counts.",
        filters: []
    },
    "5": {
        title: "Aggregate players by nationality: count players and total goals scored per nationality",
        description: "Aggregates player information grouped by nationality.",
        filters: ["country"]
    },
    "6": {
        title: "Players whose pass completion is above the overall average",
        description: "Lists players with pass completion percentages above the overall average.",
        filters: []
    },
    "7": {
        title: "Count the number of wins per club",
        description: "Counts wins per club. Use the club filter to narrow down the results.",
        filters: ["club"]
    },
    "8": {
        title: "Average number of assists made by players for each club",
        description: "Calculates the average assists per club. Optionally filter by club.",
        filters: ["club"]
    },
    "9": {
        title: "List clubs with at least one player older than the overall average age",
        description: "Lists clubs that have one or more players above the overall average age.",
        filters: []
    },
    "10": {
        title: "Players who have scored above the overall average number of goals",
        description: "Lists players who scored more than the average number of goals.",
        filters: []
    },
    "11": {
        title: "List each player along with the number of matches played",
        description: "Displays players along with their total number of matches played.",
        filters: ["player"]
    },
    "12": {
        title: "List each player with their goal and assist totals along with their nationality",
        description: "Displays players along with their goals, assists, and nationality.",
        filters: ["player"]
    },
    "13": {
        title: "List each match along with the total goals scored",
        description: "Aggregates the total goals scored in each match.",
        filters: []
    },
    "14": {
        title: "Club with the highest average pass completion percentage among its players",
        description: "Identifies the club with the best overall pass completion percentage.",
        filters: []
    },
    "15": {
        title: "List the names of players whose clubs have won at least one match",
        description: "Lists players from clubs that have recorded at least one win.",
        filters: []
    }
};

// const filterTemplates = {
//     club: (
//         <div className="form-group">
//             <label htmlFor="clubFilter">Select Club:</label>
//             <select id="clubFilter" className="form-control">
//                 <option value="all">All Clubs</option>
//                 <option value="club1">FC Barcelona</option>
//                 <option value="club2">Real Madrid</option>
//                 <option value="club3">Manchester United</option>
//                 <option value="club4">Manchester City</option>
//             </select>
//         </div>
//     ),
//     player: (
//         <div className="form-group">
//             <label htmlFor="playerFilter">Select Player:</label>
//             <select id="playerFilter" className="form-control">
//                 <option value="all">All Players</option>
//                 <option value="player1">Kylian Mbappe</option>
//                 <option value="player2">Christiano Ronaldo</option>
//                 <option value="player3">Lionel Messi</option>
//                 <option value="player4">Neymar Jr</option>
//             </select>
//         </div>
//     ),
//     country: (
//         <div className="form-group">
//             <label htmlFor="countryFilter">Select Country:</label>
//             <select id="countryFilter" className="form-control">
//                 <option value="all">All Countries</option>
//                 <option value="country1">Argentina</option>
//                 <option value="country2">Germany</option>
//                 <option value="country3">England</option>
//                 <option value="country4">France</option>
//             </select>
//         </div>
//     ),
// };

const Football = () => {
    const [currentQueryId, setCurrentQueryId] = useState(null);
    const [filters, setFilters] = useState({});
    const [results, setResults] = useState("");

    const [clubs, setClubs] = useState([]);
    const [players, setPlayers] = useState([]);
    const [countries, setCountries] = useState([]);

    const [query, setQuery] = useState(""); // State to store the query input


    const [loading, setLoading] = useState(false);

    const [query1Data, setQuery1Data] = useState([]); // State to store Query 1 data
    const [query2Data, setQuery2Data] = useState([]); // State to store Query 2 data

    const [query3Data, setQuery3Data] = useState([]); // State to store Query 3 data
    const [query4Data, setQuery4Data] = useState([]); // State to store Query 4 data
    const [query5Data, setQuery5Data] = useState([]); // State to store Query 5 data
    const [query6Data, setQuery6Data] = useState([]); // State to store Query 6 data

    const [query7Data, setQuery7Data] = useState([]); // State to store Query 7 data
    const [query8Data, setQuery8Data] = useState([]); // State to store Query 8 data
    const [query9Data, setQuery9Data] = useState([]); // State to store Query 9 data
    const [query10Data, setQuery10Data] = useState([]); // State to store Query 10 data
    const [query11Data, setQuery11Data] = useState([]); // State to store Query 11 data
    const [query12Data, setQuery12Data] = useState([]); // State to store Query 12 data
    const [query13Data, setQuery13Data] = useState([]); // State to store Query 13 data
    const [query14Data, setQuery14Data] = useState([]); // State to store Query 14 data
    const [query15Data, setQuery15Data] = useState([]); // State to store Query 15 data

    // Fetch data for Query 1
    const fetchQuery1Data = async () => {
        // written by me
        // setQuery1Data([]); // Clear previous data
        setLoading(true);
        try {
            // following line added by me
            const clubFilter = filters.club || 'all'; // Get the selected club filter
            console.log('Selected club filter:', clubFilter); // Log the selected club filter
            const response = await fetch(`http://localhost:5000/api/query1?club=${encodeURIComponent(clubFilter)}`);
            const data = await response.json();
            // console.log('Query 1 API response:', data); // Log the API response
            setQuery1Data(data);
        } catch (error) {
            console.error('Error fetching Query 1 data:', error);
            // written by me
            // setQuery1Data([]); // Clear data on error
        } finally {
            setLoading(false);
        }
    };

    // Fetch data for Query 2
    // const fetchQuery2Data = async () => {
    //     setLoading(true);
    //     try {
    //         const response = await fetch('http://localhost:5000/api/query2');
    //         const data = await response.json();
    //         setQuery2Data(data);
    //     } catch (error) {
    //         console.error('Error fetching Query 2 data:', error);
    //     } finally {
    //         setLoading(false);
    //     }
    // };
    // const fetchQuery2Data = async () => {
    //     setLoading(true);
    //     try {
    //         const clubFilter = filters.club || 'all'; // Get the selected club filter
    //         console.log('Selected club filter:', clubFilter); // Log the selected club filter
    //         const response = await fetch(`http://localhost:5000/api/query2?club=${encodeURIComponent(clubFilter)}`);
    //         const data = await response.json();
    //         setQuery2Data(data);
    //     } catch (error) {
    //         console.error('Error fetching Query 2 data:', error);
    //     } finally {
    //         setLoading(false);
    //     }
    // };

    const fetchQuery2Data = async () => {
        setLoading(true);
        try {
            const clubFilter = filters.club || 'all'; // Get the selected club filter
            console.log('Selected club filter for Query 2:', clubFilter); // Log the selected club filter
            const response = await fetch(`http://localhost:5000/api/query2?club=${encodeURIComponent(clubFilter)}`);
            const data = await response.json();
            console.log('Query 2 API response:', data); // Log the API response
            setQuery2Data(data);
        } catch (error) {
            console.error('Error fetching Query 2 data:', error);
        } finally {
            setLoading(false);
        }
    };




    // Fetch data for Query 3
    const fetchQuery3Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query3');
            const data = await response.json();
            setQuery3Data(data);
        } catch (error) {
            console.error('Error fetching Query 3 data:', error);
        } finally {
            setLoading(false);
        }
    };
    // Fetch data for Query 4
    const fetchQuery4Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query4');
            const data = await response.json();
            setQuery4Data(data);
        } catch (error) {
            console.error('Error fetching Query 4 data:', error);
        } finally {
            setLoading(false);
        }
    };
    // Fetch data for Query 5
    const fetchQuery5Data = async () => {
        setLoading(true);
        try {
            const nationalityFilter = filters.country || 'all'; // Get the selected nationality filter
            console.log('Selected nationality filter for Query 5:', nationalityFilter); // Log the selected nationality filter
            const response = await fetch(`http://localhost:5000/api/query5?nationality=${encodeURIComponent(nationalityFilter)}`);
            const data = await response.json();
            console.log('Query 5 API response:', data); // Log the API response
            setQuery5Data(data);
        } catch (error) {
            console.error('Error fetching Query 5 data:', error);
        } finally {
            setLoading(false);
        }
    };

    //fetch data for query 6
    const fetchQuery6Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query6');
            const data = await response.json();
            setQuery6Data(data);
        } catch (error) {
            console.error('Error fetching Query 6 data:', error);
        } finally {
            setLoading(false);
        }
    };
    // //fetch data for query 7
    // const fetchQuery7Data = async () => {
    //     setLoading(true);
    //     try {
    //         const clubFilter = filters.club || 'all'; // Get the selected club filter
    //         console.log('Selected club filter for Query 7:', clubFilter); // Log the selected club filter
    //         const response = await fetch(`http://localhost:5000/api/query7?club=${encodeURIComponent(clubFilter)}`); 

    //         const data = await response.json();
    //         setQuery7Data(data);
    //     } catch (error) {
    //         console.error('Error fetching Query 7 data:', error);
    //     } finally {
    //         setLoading(false);
    //     }
    // };

    const fetchQuery7Data = async () => {
        setLoading(true);
        try {
            const clubFilter = filters.club || 'all'; // Use the correct filter key
            console.log('Selected club filter for Query 7:', clubFilter); // Log the selected club filter
            const response = await fetch(`http://localhost:5000/api/query7?club=${encodeURIComponent(clubFilter)}`);
            const data = await response.json();
            console.log('Query 7 API response:', data); // Log the API response
            setQuery7Data(data);
        } catch (error) {
            console.error('Error fetching Query 7 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 8
    const fetchQuery8Data = async () => {
        setLoading(true);
        try {
            const clubFilter = filters.club || 'all'; // Get the selected club filter
            console.log('Selected club filter for Query 8:', clubFilter); // Log the selected club filter
            const response = await fetch(`http://localhost:5000/api/query8?club=${encodeURIComponent(clubFilter)}`);
            const data = await response.json();
            setQuery8Data(data);
        } catch (error) {
            console.error('Error fetching Query 8 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 9
    const fetchQuery9Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query9');
            const data = await response.json();
            setQuery9Data(data);
        } catch (error) {
            console.error('Error fetching Query 9 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 10
    const fetchQuery10Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query10');
            const data = await response.json();
            setQuery10Data(data);
        } catch (error) {
            console.error('Error fetching Query 10 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 11
    const fetchQuery11Data = async () => {
        setLoading(true);
        try {
            const playerFilter = filters.player || 'all'; // Get the selected player filter
            console.log('Selected player filter for Query 11:', playerFilter); // Log the selected player filter
            const response = await fetch(`http://localhost:5000/api/query11?player=${encodeURIComponent(playerFilter)}`);

            const data = await response.json();
            setQuery11Data(data);
        } catch (error) {
            console.error('Error fetching Query 11 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 12
    const fetchQuery12Data = async () => {
        setLoading(true);
        try {
            const playerFilter = filters.player || 'all'; // Get the selected player filter
            console.log('Selected player filter for Query 12:', playerFilter); // Log the selected player filter
            const response = await fetch(`http://localhost:5000/api/query12?player=${encodeURIComponent(playerFilter)}`);

            const data = await response.json();
            setQuery12Data(data);
        } catch (error) {
            console.error('Error fetching Query 12 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 13
    const fetchQuery13Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query13');
            const data = await response.json();
            setQuery13Data(data);
        } catch (error) {
            console.error('Error fetching Query 13 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 14
    const fetchQuery14Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query14');
            const data = await response.json();
            setQuery14Data(data);
        } catch (error) {
            console.error('Error fetching Query 14 data:', error);
        } finally {
            setLoading(false);
        }
    };
    //fetch data for query 15
    const fetchQuery15Data = async () => {
        setLoading(true);
        try {
            const response = await fetch('http://localhost:5000/api/query15');
            const data = await response.json();
            setQuery15Data(data);
        } catch (error) {
            console.error('Error fetching Query 15 data:', error);
        } finally {
            setLoading(false);
        }
    };





    // Fetch clubs, players, and countries on component mount
    useEffect(() => {
        const fetchClubs = async () => {
            const response = await fetch('http://localhost:5000/api/clubs');
            const data = await response.json();
            setClubs(data);
        };

        const fetchPlayers = async () => {
            const response = await fetch('http://localhost:5000/api/players');
            const data = await response.json();
            setPlayers(data);
        };

        const fetchCountries = async () => {
            const response = await fetch('http://localhost:5000/api/countries');
            const data = await response.json();
            setCountries(data);
        };

        fetchClubs();
        fetchPlayers();
        fetchCountries();
    }, []);

    // Fetch Query 1 data when the component mounts
    // written by me, following three lines commented
    // useEffect(() => {
    //     fetchQuery1Data();
    // }, []);
    // Fetch Query 2 data when the component mounts
    // useEffect(() => {
    //     fetchQuery2Data();
    // }, []);
    // Fetch Query 3 data when the component mounts
    // useEffect(() => {
    //     fetchQuery3Data();
    // }, []);
    // Fetch Query 4 data when the component mounts
    // useEffect(() => {
    //     fetchQuery4Data();
    // }, []);
    // // Fetch Query 5 data when the component mounts
    // useEffect(() => {
    //     fetchQuery5Data();
    // }, []);
    // Fetch Query 6 data when the component mounts
    // useEffect(() => {
    //     fetchQuery6Data();
    // }, []);
    // // Fetch Query 7 data when the component mounts
    // // useEffect(() => {
    // //     fetchQuery7Data();
    // // }, []);
    // // Fetch Query 8 data when the component mounts
    // // useEffect(() => {
    // //     fetchQuery8Data();
    // // }, []);
    // Fetch Query 9 data when the component mounts
    // useEffect(() => {
    //     fetchQuery9Data();
    // }, []);
    // Fetch Query 10 data when the component mounts
    // useEffect(() => {
    //     fetchQuery10Data();
    // }, []);
    // // Fetch Query 11 data when the component mounts
    // // useEffect(() => {
    // //     fetchQuery11Data();
    // // }, []);
    // // Fetch Query 12 data when the component mounts
    // // useEffect(() => {
    // //     fetchQuery12Data();
    // // }, []);
    // Fetch Query 13 data when the component mounts
    // useEffect(() => {
    //     fetchQuery13Data();
    // }, []);
    // Fetch Query 14 data when the component mounts
    // useEffect(() => {
    //     fetchQuery14Data();
    // }, []);
    // Fetch Query 15 data when the component mounts
    // useEffect(() => {
    //     fetchQuery15Data();
    // }, []);




    const handleQueryClick = (queryId) => {
        setCurrentQueryId(queryId);
        setFilters({});
        setResults("");
        // Written by me, added following one line
        setQuery1Data([]); // Clear Query 1 data
    };



    const handleRunQuery = async () => {
        if (!currentQueryId) return;

        setLoading(true);
        try {
            if (currentQueryId === '1') {
                console.log('Running Query 1 with club filter:', filters.club); // Log the club filter
                await fetchQuery1Data(); // Fetch Query 1 data with filters
            } else if (currentQueryId === '2') {
                console.log('Running Query 2 with club filter:', filters.club); // Log the club filter
                await fetchQuery2Data(); // Fetch Query 2 data with filters
            } else if (currentQueryId === '3') {
                console.log('Running Query 3 with player filter:', filters.player); // Log the player filter
                await fetchQuery3Data(); // Fetch Query 3 data with filters
            } else if (currentQueryId === '4') {
                console.log('Running Query 4 with player filter:', filters.player); // Log the player filter
                await fetchQuery4Data(); // Fetch Query 4 data with filters
            }
            else if (currentQueryId === '5') {
                console.log('Running Query 5 with nationality filter:', filters.nationality); // Log the club filter
                await fetchQuery5Data(); // Fetch Query 5 data with filters 
            } else if (currentQueryId === '6') {
                console.log('Running Query 6 with player filter:', filters.player); // Log the player filter
                await fetchQuery6Data(); // Fetch Query 6 data with filters
            }
            else if (currentQueryId === '7') {
                console.log('Running Query 7 with club filter:', filters.nationality); // Log the nationality filter
                await fetchQuery7Data(); // Fetch Query 7 data with filters
            } else if (currentQueryId === '8') {
                console.log('Running Query 8 with club filter:', filters.nationality); // Log the nationality filter
                await fetchQuery8Data(); // Fetch Query 8 data with filters
            } else if (currentQueryId === '9') {
                console.log('Running Query 9 with player filter:', filters.player); // Log the player filter
                await fetchQuery9Data(); // Fetch Query 9 data with filters
            } else if (currentQueryId === '10') {
                console.log('Running Query 10 with player filter:', filters.player); // Log the player filter
                await fetchQuery10Data(); // Fetch Query 10 data with filters
            }
            else if (currentQueryId === '11') {
                console.log('Running Query 11 with player filter:', filters.nationality); // Log the nationality filter
                await fetchQuery11Data(); // Fetch Query 11 data with filters
            } else if (currentQueryId === '12') {
                console.log('Running Query 12 with player filter:', filters.nationality); // Log the nationality filter
                await fetchQuery12Data(); // Fetch Query 12 data with filters
            } else if (currentQueryId === '13') {
                console.log('Running Query 13 with player filter:', filters.nationality); // Log the nationality filter
                await fetchQuery13Data(); // Fetch Query 13 data with filters
            } else if (currentQueryId === '14') {
                console.log('Running Query 14 with player filter:', filters.nationality); // Log the nationality filter
                await fetchQuery14Data(); // Fetch Query 14 data with filters
            } else if (currentQueryId === '15') {
                console.log('Running Query 15 with player filter:', filters.nationality); // Log the nationality filter
                await fetchQuery15Data(); // Fetch Query 15 data with filters
            }

            else {
                const response = await fetch('http://localhost:5000/api/query', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ queryId: currentQueryId, filters }),
                });
                const data = await response.json();
                setResults(data);
            }
        } catch (error) {
            console.error('Error fetching query results:', error);
        } finally {
            setLoading(false);
        }
    };

    const queryInfo = queries[currentQueryId];



    const filterTemplates = {
        // commented by me, club
        // club: (
        //     <div className="form-group">
        //         <label htmlFor="clubFilter">Select Club:</label>
        //         {/* <select
        //             id="clubFilter"
        //             className="form-control"
        //             onChange={(e) => setFilters({ ...filters, club: e.target.value })}
        //         >
        //             <option value="all">All Clubs</option>
        //             {clubs.map((club, index) => (
        //                 <option key={index} value={club}>
        //                     {club}
        //                 </option>
        //             ))}
        //         </select> */}


        //         <select id="clubFilter" className="form-control">
        //             <option value="all">All Clubs</option>
        //             {clubs.map((club, index) => (
        //                 <option key={index} value={club}>
        //                     {club}
        //                 </option>
        //             ))}
        //         </select>
        //     </div>
        // ),

        // written by me, only club
        club: (
            <div className="form-group">
                <label htmlFor="clubFilter">Select Club:</label>
                <select
                    id="clubFilter"
                    className="form-control"
                    onChange={(e) => setFilters({ ...filters, club: e.target.value })}
                >
                    <option value="all">All Clubs</option>
                    {clubs.map((club, index) => (
                        <option key={index} value={club}>
                            {club}
                        </option>
                    ))}
                </select>
            </div>
        ),
        player: (
            <div className="form-group">
                <label htmlFor="playerFilter">Select Player:</label>
                <select
                    id="playerFilter"
                    className="form-control"
                    onChange={(e) => setFilters({ ...filters, player: e.target.value })}
                >
                    <option value="all">All Players</option>
                    {players.map((player, index) => (
                        <option key={index} value={player}>
                            {player}
                        </option>
                    ))}
                </select>
            </div>
        ),
        country: (
            <div className="form-group">
                <label htmlFor="countryFilter">Select Country:</label>
                <select
                    id="countryFilter"
                    className="form-control"
                    onChange={(e) => setFilters({ ...filters, country: e.target.value })}
                >
                    <option value="all">All Countries</option>
                    {countries.map((country, index) => (
                        <option key={index} value={country}>
                            {country}
                        </option>
                    ))}
                </select>
            </div>
        ),
    };

    const DataTable = ({ headers, data }) => {
        return (
            <div className="data-table">
                <table className="table table-bordered">
                    <thead>
                        <tr>
                            {headers.map((header, index) => (
                                <th key={index}>{header}</th>
                            ))}
                        </tr>
                    </thead>
                    <tbody>
                        {data.map((row, rowIndex) => (
                            <tr key={rowIndex}>
                                {Object.values(row).map((value, colIndex) => (
                                    <td key={colIndex}>{typeof value === 'number' ? value.toFixed(2) : value}</td>
                                ))}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        );
    };

    return (
        <div className="container-fluid">
            <nav className="sidebar">

                <div><h1 style={{ color: 'black' }}>Queries</h1></div>


                <div className="list-group">
                    {Object.entries(queries).map(([id, query]) => (
                        <a
                            key={id}
                            href="#"
                            className={`list-group-item ${currentQueryId === id ? 'active' : ''}`}
                            onClick={() => handleQueryClick(id)}
                        >
                            {id}. {query.title}
                        </a>
                    ))}
                </div>



            </nav>

            <main className="main-content">
                <h2>{queryInfo?.title || "Football Team Analysis"}</h2>
                <p>{queryInfo?.description || "Click on a query from the sidebar to see its details."}</p>







                {queryInfo?.filters && (
                    <div className="filter-section">
                        <h5>Filters</h5>
                        {queryInfo.filters.map((filter) => filterTemplates[filter])}
                    </div>
                )}
                {queryInfo && (

                    <button className="btn-primary" onClick={handleRunQuery} disabled={loading}>
                        {loading ? 'Loading...' : 'Run Query'}
                    </button>
                )}



                <div className='query-result-box'>

                    {results && <div className="query-result"><pre>{JSON.stringify(results, null, 2)}</pre></div>}

                    {/* Render Query 1 data if the current query is 1 */}
                    {currentQueryId === "1" && query1Data.length > 0 && (
                        <div className="query1-result ">
                            <div>  <h3 >Query 1 Results</h3></div>
                            <br />
                            <div> <table className="table table-bordered align-items-center justify-content-center">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        <th>Number_Of_Players</th>
                                        <th>Average_Age</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query1Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club_name}</td>
                                            <td>{row.num_players}</td>
                                            <td>{row.avg_age.toFixed(2)}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table></div>
                        </div>
                    )}


                    {/* Render Query 2 data if the current query is 2 */}
                    {currentQueryId === "2" && query2Data.length > 0 && (
                        <div className="query2-result">
                            <div><h3>Query 2 Results</h3></div> <br />
                           <div> <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        <th>Total_Goals</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query2Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club_name}</td>
                                            <td>{row.total_goals}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table></div>
                        </div>
                    )}
                    {/* Render Query 3 data if the current query is 3 */}
                    {currentQueryId === "3" && query3Data.length > 0 && (
                        <div className="query3-result">
                            <h3>Query 3 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Name</th>
                                        <th>Total_Goals</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query3Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_name}</td>
                                            <td>{row.goals}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 4 data if the current query is 4 */}
                    {currentQueryId === "4" && query4Data.length > 0 && (
                        <div className="query4-result">
                            <h3>Query 4 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Name</th>
                                        <th>Total_Assists</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query4Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_name}</td>
                                            <td>{row.assists}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 5 data if the current query is 5 */}
                    {currentQueryId === "5" && query5Data.length > 0 && (
                        <div className="query5-result">
                            <h3>Query 5 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Country</th>
                                        <th>Player_Count</th>
                                        <th>Total_Goals</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query5Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.nationality}</td>
                                            <td>{row.num_players}</td>
                                            <td>{row.total_goals}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>






                        </div>


                    )}

                    {/* Render Query 6 data if the current query is 6 */}
                    {currentQueryId === "6" && query6Data.length > 0 && (
                        <div className="query6-result">
                            <h3>Query 6 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Id</th>
                                        <th>Player_Name</th>
                                        <th></th>
                                        <th>Pass Completion Percentage</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query6Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_id}</td>
                                            <td>{row.player_name}</td>
                                            <td>{row.percentage_passes_completed}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 7 data if the current query is 7 */}
                    {currentQueryId === "7" && query7Data.length > 0 && (
                        <div className="query7-result">
                            <h3>Query 7 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        <th>Total_Wins</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query7Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club}</td>
                                            <td>{row.wins}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 8 data if the current query is 8 */}
                    {currentQueryId === "8" && query8Data.length > 0 && (
                        <div className="query8-result">
                            <h3>Query 8 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        <th>Average_Assists</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query8Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club_name}</td>
                                            <td>{row.avg_assists}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 9 data if the current query is 9 */}
                    {currentQueryId === "9" && query9Data.length > 0 && (
                        <div className="query9-result">
                            <h3>Query 9 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        {/* <th>Player_Count_Above_Average_Age</th> */}
                                    </tr>
                                </thead>
                                <tbody>
                                    {query9Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club_name}</td>
                                            <td>{row.player_count_above_avg_age}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 10 data if the current query is 10 */}
                    {currentQueryId === "10" && query10Data.length > 0 && (
                        <div className="query10-result">
                            <h3>Query 10 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Id</th>
                                        <th>Player_Name</th>
                                        <th>Total_Goals</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query10Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_id}</td>
                                            <td>{row.player_name}</td>
                                            <td>{row.goals}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 11 data if the current query is 11 */}
                    {currentQueryId === "11" && query11Data.length > 0 && (
                        <div className="query11-result">
                            <h3>Query 11 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Id</th>
                                        <th>Playe_Name</th>
                                        <th>Total_Matches_Played</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query11Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_id}</td>
                                            <td>{row.player_name}</td>
                                            <td>{row.matches_played}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 12 data if the current query is 12 */}
                    {currentQueryId === "12" && query12Data.length > 0 && (
                        <div className="query12-result">
                            <h3>Query 12 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Id</th>
                                        <th>Player_Name</th>
                                        <th>Club_Name</th>
                                        <th>Goals</th>
                                        <th>Assits</th>
                                        <th>Nationality</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query12Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_id}</td>
                                            <td>{row.player_name}</td>
                                            <td>{row.club_name}</td>

                                            <td>{row.goals}</td>
                                            <td>{row.assists}</td>
                                            <td>{row.nationality}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>





                    )}
                    {/* Render Query 13 data if the current query is 13 */}
                    {currentQueryId === "13" && query13Data.length > 0 && (
                        <div className="query13-result">
                            <h3>Query 13 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Match_ID</th>
                                        <th>Home_Team</th>
                                        <th>Away_Team</th>
                                        <th>Total_Goals</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query13Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.match_id}</td>
                                            <td>{row.home_team}</td>
                                            <td>{row.away_team}</td>
                                            <td>{row.total_goals}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 14 data if the current query is 14 */}
                    {currentQueryId === "14" && query14Data.length > 0 && (
                        <div className="query14-result">
                            <h3>Query 14 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Club_Name</th>
                                        <th> Average_Pass_Completion</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query14Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.club_name}</td>
                                            <td>{row.avg_pass_completion}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}
                    {/* Render Query 15 data if the current query is 15 */}
                    {currentQueryId === "15" && query15Data.length > 0 && (
                        <div className="query15-result">
                            <h3>Query 15 Results</h3> <br />
                            <table className="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Player_Name</th>
                                        <th>Club_Name</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {query15Data.map((row, index) => (
                                        <tr key={index}>
                                            <td>{row.player_name}</td>
                                            <td>{row.club_name}</td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    )}

                </div>

            </main>
        </div>
    );
};

export default Football;