const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-06-test.txt").
    toString().trim().split(",").map(Number);
var input = fs.readFileSync(__dirname + "/day-06.txt").
    toString().trim().split(",").map(Number);

// Part 1

function initialize(input) {
    const fishByDays = { 0: 0, 1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0, 7: 0, 8: 0 };

    input.forEach(function(num) {
        fishByDays[num]++;
    });
    
    return fishByDays;
}

function step(fishByDays) {
    // use new dict to avoid overwriting
    const nextFishByDays = {};

    // decrease days of all fish w/ days > 1
    for(let i = 1; i <= 8; i++) {
        nextFishByDays[i-1] = fishByDays[i];
    }

    // reset fish w/ days == 0 and spawn new fish
    nextFishByDays[6] += fishByDays[0];
    nextFishByDays[8] = fishByDays[0];

    return nextFishByDays;
}

function countFish(fishByDays) {
    let sum = 0;

    for(var key in fishByDays) {
        sum += fishByDays[key];
    }

    return sum;
}

function simulate(fishByDays, days) {
    for(let i = 0; i < days; i++) {
        fishByDays = step(fishByDays);
    }

    return fishByDays;
}

testInitFishByDays = initialize(testInput);
testFishByDays = simulate(testInitFishByDays, 18);

assert(countFish(testFishByDays) == 26);

initFishByDays = initialize(input);
fishByDays = simulate(initFishByDays, 80);

console.log("Part 1: " + countFish(fishByDays));

// Part 2

testFishByDays = simulate(testInitFishByDays, 256);

assert(countFish(testFishByDays) == 26984457539);

fishByDays = simulate(initFishByDays, 256);

console.log("Part 2: " + countFish(fishByDays));


