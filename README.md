# freeCodeCamp World Cup Database

This project is part of the freeCodeCamp Relational Database certification.  
It uses PostgreSQL to store FIFA World Cup match data from the final three rounds of the tournaments since 2014.

## Project Files

- `worldcup.sql` — PostgreSQL dump of the finished database.
- `insert_data.sh` — Bash script that imports data from `games.csv` into the database.
- `queries.sh` — Bash script that runs the required SQL queries for the project.
- `games.csv` — Source data provided by freeCodeCamp.

## Database Structure

The project contains two tables:

### `teams`
Stores the teams that appear in the World Cup matches.

- `team_id` — `SERIAL` primary key
- `name` — unique team name

### `games`
Stores match data.

- `game_id` — `SERIAL` primary key
- `year` — tournament year
- `round` — round of the match
- `winner_id` — foreign key referencing `teams.team_id`
- `opponent_id` — foreign key referencing `teams.team_id`
- `winner_goals` — goals scored by the winning team
- `opponent_goals` — goals scored by the opponent

## Setup

To recreate the database from the dump file:

```bash
psql -U postgres < worldcup.sql
```

To run the insert script:

```bash
chmod +x insert_data.sh
./insert_data.sh
```

To run the query script:

```bash
chmod +x queries.sh
./queries.sh
```

## Notes

- The project database name is `worldcup`.
- The `insert_data.sh` script inserts each unique team into the `teams` table and then inserts all match rows into `games`.
- The `queries.sh` script prints the required answers in the exact format expected by freeCodeCamp.
- Both shell scripts should have executable permissions before running tests.

## Result

The project was completed successfully and passed all freeCodeCamp tests.