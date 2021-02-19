import React, { useState, useEffect } from 'react';
import "phoenix_html";
import ReactDOM from 'react-dom';
import {ch_reset, ch_join, ch_push} from "./socket";


function Bulls() {
  const [state, setState] = useState({
    guesses: [],
    bullsCowsList: [],
    isGameOver: false,
  });

  const [currGuess, setCurrGuess] = useState("");

  let { guesses,
	bullsCowsList,
	isGameOver} = state;

  useEffect(() => {
	console.log("sukhmansinghiscool");
   	ch_join(setState);
  });

  function makeGuess(guess) {
	  if (state.isGameOver) {
	  	console.log("GameIsOverNoMoreGuessing");
	  }
	  else {
	  	console.log(guess);
		ch_push({letter: guess});
	  }
  }

  function keypress(ev) {
    if (ev.key === "Enter") {
      makeGuess(currGuess);
    }
  }

  function updateGuess(ev) {
    let input = ev.target.value;
    if (!isNaN(input)) {
      setCurrGuess(input);
    }
  }

  function resetGame() {
    console.log("resetting game");
    ch_reset();
  }

  function resultString(guessNum) {
    if (guesses[guessNum - 1] === undefined) {
      return "";
    }

    const bulls = bullsCowsList[guessNum - 1][0]
    const cows = bullsCowsList[guessNum - 1][1]

    return "Bulls: " + bulls + " Cows: " + cows;
  }

  function endGameText() {
    if (isGameOver) {
      if (
        guesses.length >= 8 &&
        bullsCowsList[7][0] !== 4
      ) {
        return "YOU LOST!";
      } else {
        return "YOU WON! The code was " + guesses[guesses.length - 1];
      }
    } else {
      return "";
    }
  }

  return (
    <div className="App">
      <div className="reset">
        <button onClick={resetGame}>Reset</button>
      </div>

      <div id="inputArea">
        <label>Input:</label>
        <input
          id="guessInput"
          maxLength="4"
          value={currGuess}
          onChange={updateGuess}
          onKeyPress={keypress}
        />
        <button id="guess" onClick={makeGuess(currGuess)}>Guess</button>
      </div>

      <table>
        <tbody>
          <tr>
            <th></th>
            <th>Guess</th>
            <th className="resultCol">Result</th>
          </tr>
          <tr>
            <th>1</th>
            <th>{guesses[0]}</th>
            <th className="resultCol">{resultString(1)}</th>
          </tr>
          <tr>
            <th>2</th>
            <th>{guesses[1]}</th>
            <th className="resultCol">{resultString(2)}</th>
          </tr>
          <tr>
            <th>3</th>
            <th>{guesses[2]}</th>
            <th className="resultCol">{resultString(3)}</th>
          </tr>
          <tr>
            <th>4</th>
            <th>{guesses[3]}</th>
            <th className="resultCol">{resultString(4)}</th>
          </tr>
          <tr>
            <th>5</th>
            <th>{guesses[4]}</th>
            <th className="resultCol">{resultString(5)}</th>
          </tr>
          <tr>
            <th>6</th>
            <th>{guesses[5]}</th>
            <th className="resultCol">{resultString(6)}</th>
          </tr>
          <tr>
            <th>7</th>
            <th>{guesses[6]}</th>
            <th className="resultCol">{resultString(7)}</th>
          </tr>
          <tr>
            <th>8</th>
            <th>{guesses[7]}</th>
            <th className="resultCol">{resultString(8)}</th>
          </tr>
        </tbody>
      </table>
      <div id="errorMessage">{"Provide a valid input: 4 unique numbers"}</div>
      <div id="endGameText">{endGameText()}</div>
    </div>
  );
}

ReactDOM.render(
  <React.StrictMode>
    <Bulls />
  </React.StrictMode>,
  document.getElementById('root')
);

export default Bulls;
