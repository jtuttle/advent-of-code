const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-01-test.txt").
    toString().trim().split("\n").map(Number);
var input = fs.readFileSync(__dirname + "/day-01.txt").
    toString().trim().split("\n").map(Number);

// Part 1

function countAscending(input) {
    count = 0;

    for(i = 1; i < input.length - 1; i++) {
	if(input[i] > input[i-1]) {
	//if(parseInt(input[i]) > parseInt(input[i-1])) {
	    count++;
	}
    }

    return count;
}

assert(countAscending(testInput) == 7);

console.log("Part 1: " + countAscending(input))

// Part 2

function countAscendingWindow(input) {
    count = 0;

    for(i = 3; i < input.length - 1; i++) {
	window1 = input[i-3] + input[i-2] + input[i-1]
	window2 = input[i-2] + input[i-1] + input[i]
	
	if(window2 > window1) {
	    count++;
	}
    }

    return count;
}

assert(countAscendingWindow(testInput) == 5);

console.log("Part 2: " + countAscendingWindow(input))
