const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-03-test.txt").
    toString().trim().split("\n");
var input = fs.readFileSync(__dirname + "/day-03.txt").
    toString().trim().split("\n");

// Part 1

function countAllOnes(input) {
    oneCounts = new Array(input[0].length).fill(0);

    input.forEach(function(line) {
        for(i = 0; i < line.length; i++) {
            if(line[i] == '1') {
                oneCounts[i]++;
            }
        }
    });

    return oneCounts;
}

function gamma(oneCounts, lineCount, lineCompareFunc) {
    binary = ""
    
    oneCounts.forEach(function(count) {
        binary += (count > lineCount / 2 ? '1' : '0');
    });

    return parseInt(binary, 2);
}

// There's probably a way to be clever here and flip bits to get the one's
// complement of gamma, but I wasn't able to figure it out quickly using JS
// bitwise operators so this is quicker.
function epsilon(oneCounts, lineCount, lineCompareFunc) {
    binary = ""
    
    oneCounts.forEach(function(count) {
        binary += ((count < lineCount / 2) ? '1' : '0')
    });

    return parseInt(binary, 2);
}

function powerConsumption(input) {
    oneCounts = countAllOnes(input);

    return gamma(oneCounts, input.length) * epsilon(oneCounts, input.length);
}

assert(powerConsumption(testInput) == 198);

console.log("Part 1: " + powerConsumption(input));

// Part 2

function countOnesAtPos(input, pos) {
    oneCount = 0;

    input.forEach(function(line) {
        if(line[pos] == '1') { oneCount++; }
    });

    return oneCount;
}

function oxygenGeneratorRating(input) {
    for(i = 0; i < input[0].length; i++) {
        oneCount = countOnesAtPos(input, i);
        target = (oneCount >= (input.length / 2) ? '1' : '0');

        input = input.filter(function(line) {
            return line[i] == target;
        });

        if(input.length == 1) { return parseInt(input[0], 2); }
    }
}

function co2ScrubberRating(input) {
    for(i = 0; i < input[0].length; i++) {
        oneCount = countOnesAtPos(input, i);
        target = (oneCount < (input.length / 2) ? '1' : '0');

        input = input.filter(function(line) {
            return line[i] == target;
        });

        if(input.length == 1) { return parseInt(input[0], 2); }
    }
}

function lifeSupportRating(input) {
    return oxygenGeneratorRating(input) * co2ScrubberRating(input);
}

assert(lifeSupportRating(testInput) == 230);

console.log("Part 1: " + lifeSupportRating(input));
