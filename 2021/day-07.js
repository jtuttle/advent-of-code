const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-07-test.txt").
    toString().trim().split(",").map(Number);
var input = fs.readFileSync(__dirname + "/day-07.txt").
    toString().trim().split(",").map(Number);

// Part 1

function minFuel(positions) {
    let minFuel = Infinity;

    const min = Math.min(...positions);
    const max = Math.max(...positions);

    for(let i = min; i <= max; i++) {
        let fuel = 0

        positions.forEach(function(pos) {
            fuel += Math.abs(i - pos);
        });

        if(fuel < minFuel) {
            minFuel = fuel;
        }
    }

    return minFuel;
}

assert(minFuel(testInput) == 37);

console.log("Part 1: " + minFuel(input));

// Part 2

function minFuel2(positions) {
    let minFuel = Infinity;

    const min = Math.min(...positions);
    const max = Math.max(...positions);

    for(let i = min; i <= max; i++) {
        let fuel = 0

        positions.forEach(function(pos) {
            let diff = Math.abs(i - pos);

            for(let j = 1; j <= diff; j++) {
                fuel += j;
            }
        });

        
        if(fuel < minFuel) {
            minFuel = fuel;
        }
    }

    return minFuel;
}

assert(minFuel2(testInput) == 168);

console.log("Part 2: " + minFuel2(input));
