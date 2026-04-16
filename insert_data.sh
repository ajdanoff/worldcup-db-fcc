#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
GET_TEAM_ID_INSERT(){
  local TEAM=$1
  # get team id
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM'")
  # if empty
  if [[ -z $TEAM_ID ]]
  then
    # insert team
    INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM')")
    if [[ $INSERT_TEAM_RESULT =~ "0 1" ]]
    then
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$TEAM'")
      echo $TEAM_ID
    fi
  else
    echo $TEAM_ID
  fi
}
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ ! $WINNER == 'winner' ]]
  then
    echo $WINNER $OPPONENT
    # get winner id
    WINNER_ID=$(GET_TEAM_ID_INSERT "$WINNER")
    echo winner id: $WINNER_ID
    # get opponent id
    OPPONENT_ID=$(GET_TEAM_ID_INSERT "$OPPONENT")
    echo opponent id: $OPPONENT_ID
    # select from games with year, round, winner id, opponent id
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year = $YEAR AND round = '$ROUND' AND winner_id = $WINNER_ID AND opponent_id = $OPPONENT_ID")
    # if not found
    if [[ -z $GAME_ID ]]
    then
      # insert into games
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
      if [[ $INSERT_GAME_RESULT =~ "0 1" ]]
      then
        GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year = $YEAR AND round = '$ROUND' AND winner_id = $WINNER_ID AND opponent_id = $OPPONENT_ID")
        echo game id: $GAME_ID
      fi
    else
      echo game id: $GAME_ID
    fi 
  fi
done
