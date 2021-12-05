const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-04-test.txt").
    toString().trim().split("\n");
var input = fs.readFileSync(__dirname + "/day-04.txt").
    toString().trim().split("\n");

// Part 1

class BingoBoard {
    constructor(values, width, height) {
        this.values = values;
        this.width = width;
        this.height = height;

        this.marks = new Array(this.values.length).fill(false);
    }

    markValue(value) {
        for(let i = 0; i < this.values.length; i++) {
            if(this.values[i] == value) {
                this.marks[i] = true;
            }
        }
    }

    checkRow(y) {
        for(let x = 0; x < this.width; x++) {
            let idx = y * this.width + x;
            if(!this.marks[idx]) { return false; }
        }
        
        return true;
    }

    checkCol(x) {
        for(let y = 0; y < this.height; y++) {
            let idx = y * this.width + x;
            if(!this.marks[idx]) { return false; }
        }

        return true;
    }

    isWinner() {
        // rows
        for(let y = 0; y < this.height; y ++) {
            if(this.checkRow(y)) { return true; }
        }

        // columns
        for(let x = 0; x < this.width; x++) {
            if(this.checkCol(x)) { return true; }
        }

        return false;
    }

    get unmarkedSum() {
        let score = 0;

        for(let i = 0; i < this.values.length; i++) {
            if(!this.marks[i]) { score += this.values[i]; }
        }

        return score;
    }
}

function parseBoards(input) {
    boards = []
    
    let i = 2;

    while(i < input.length) {
        values = []

        while(i < input.length && input[i].trim() != "") {
            line = input[i].trim();

            row = line.split(/ +/).map(Number);
            values = values.concat(row);

            i++;
        }

        boards.push(new BingoBoard(values, 5, 5));

        i++;
    }

    return boards;
}

function printBoard(board) {
    for(let y = 0; y < board.height; y++) {
        for(let x = 0; x < board.width; x++) {
            idx = y * board.width + x;

            if(board.marks[idx]) {
                process.stdout.write("XX ");
            } else {
                let value = board.values[idx].toString();
                
                // pad single digits
                if(value.length == 1) { value = " " + value };
                
                process.stdout.write(value + " ");
            }
        }

        process.stdout.write("\n");
    }
}

function firstWinnerScore(draws, boards) {
    for(let d = 0; d < draws.length; d++) {
        let draw = draws[d];

        for(let b = 0; b < boards.length; b++) {
            let board = boards[b];
            
            board.markValue(draw);

            if(board.isWinner()) {
                return board.unmarkedSum * draw;
            }
        }
    }

    return null;
}

testDraws = testInput[0].split(',').map(Number);
testBoards = parseBoards(testInput);

assert(firstWinnerScore(testDraws, testBoards) == 4512);

draws = input[0].split(',').map(Number);
boards = parseBoards(input);

console.log("Part 1: " + firstWinnerScore(draws, boards));

// Part 2

function lastWinnerScore(draws, boards) {
    const winners = new Set();
    
    for(let d = 0; d < draws.length; d++) {
        let draw = draws[d];

        for(let b = 0; b < boards.length; b++) {
            let board = boards[b];
            
            board.markValue(draw);

            if(!winners.has(b) && board.isWinner()) {
                winners.add(b);

                if(winners.size == boards.length) {
                    return board.unmarkedSum * draw;
                }
            }
        }
    }

    return null;
}

testDraws = testInput[0].split(',').map(Number);
testBoards = parseBoards(testInput);

assert(lastWinnerScore(testDraws, testBoards) == 1924);

draws = input[0].split(',').map(Number);
boards = parseBoards(input);

console.log("Part 2: " + lastWinnerScore(draws, boards));
