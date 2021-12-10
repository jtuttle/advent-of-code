const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-05-test.txt").
    toString().trim().split("\n");
var input = fs.readFileSync(__dirname + "/day-05.txt").
    toString().trim().split("\n");

// Part 1

class Coord {
    constructor(x, y) {
        this.x = x;
        this.y = y;
    }
}

function parseCoord(pipeStr) {
    split = pipeStr.split(',');
    return new Coord(parseInt(split[0]), parseInt(split[1]));
}

function printPipes(pipes, gridSize, filename) {
    str = ""
    
    for(let y = 0; y < gridSize; y++) {
        for(let x = 0; x < gridSize; x++) {
            str += pipes[y * gridSize + x];
        }
        str += "\n"
    }

    fs.writeFile(__dirname + "/" + filename, str, err => {
        if (err) {
            console.error(err)
            return
        }
    });
}

function plotPipes(input, gridSize, plotDiagonals = false) {
    let pipes = new Array(gridSize * gridSize).fill(0);

    for(let i = 0; i < input.length; i++) {
        const pipe = input[i];

        const splitPipe = pipe.split(' -> ');
        const from = parseCoord(splitPipe[0]);
        const to = parseCoord(splitPipe[1]);

        const isDiagonal = (from.x != to.x && from.y != to.y);

        // skip diagonals when not plotting them
        if(!plotDiagonals && isDiagonal) { continue; }

        let x = from.x;
        let xStep = 0;
        if(from.x < to.x) { xStep = 1; }
        if(from.x > to.x) { xStep = -1; }

        let y = from.y
        let yStep = 0;
        if(from.y < to.y) { yStep = 1; }
        if(from.y > to.y) { yStep = -1; }

        while(!(x == to.x && y == to.y)) {
            pipes[y * gridSize + x]++;
            x += xStep
            y += yStep
        }

        // plot final section of pipe missed by while loop
        pipes[y * gridSize + x]++;
    }

    return pipes;
}

function countIntersections(pipes) {
    let count = 0;
    
    for(let i = 0; i < pipes.length; i++) {
        if(pipes[i] > 1) { count++; }
    }

    return count;
}

testPipes = plotPipes(testInput, 10);

assert(countIntersections(testPipes) ==  5);

pipes = plotPipes(input, 1000);

console.log("Part 1: " + countIntersections(pipes));

// Part 2

testPipes = plotPipes(testInput, 10, true);

assert(countIntersections(testPipes) ==  12);

pipes = plotPipes(input, 1000, true);

console.log("Part 2: " + countIntersections(pipes));
