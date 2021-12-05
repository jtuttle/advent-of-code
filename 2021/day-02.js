const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-02-test.txt").
    toString().trim().split("\n");
var input = fs.readFileSync(__dirname + "/day-02.txt").
    toString().trim().split("\n");

// Part 1

function travel(input) {
    position = 0
    depth = 0
    
    input.forEach(function(line) {
        cmd = line.split(' ');

        if(cmd[0] == "forward") {
            position += parseInt(cmd[1]);
        } else if(cmd[0] == "up") {
            depth -= parseInt(cmd[1]);
        } else if(cmd[0] == "down") {
            depth += parseInt(cmd[1]);
        }
    });

    return position * depth
}

assert(travel(testInput) == 150);

console.log("Part 1: " + travel(input));

// Part 2

function travel2(input) {
    position = 0
    depth = 0
    aim = 0
    
    input.forEach(function(line) {
        cmd = line.split(' ');

        if(cmd[0] == "forward") {
            position += parseInt(cmd[1]);
            depth += aim * parseInt(cmd[1]);
        } else if(cmd[0] == "up") {
            aim -= parseInt(cmd[1]);
        } else if(cmd[0] == "down") {
            aim += parseInt(cmd[1]);
        }
    });

    return position * depth
}

assert(travel2(testInput) == 900);

console.log("Part 2: " + travel2(input));
