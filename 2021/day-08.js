const fs = require('fs');
const assert = require('assert');

var testInput = fs.readFileSync(__dirname + "/day-08-test.txt").
    toString().trim().split("\n");
var input = fs.readFileSync(__dirname + "/day-08.txt").
    toString().trim().split("\n");

// Part 1

function countUniqueSegmentDigits(input) {
    let count = 0;

    input.forEach(function(line) {
        const digits  = line.split(" | ")[1];
        const segmentGroups = digits.split(" ")

        segmentGroups.forEach(function(segmentGroup) {
            // segment counts for numbers 1,4,7,8
            if([2,4,3,7].includes(segmentGroup.length)) {
                count++;
            }
        });
    });

    return count;
}

assert(countUniqueSegmentDigits(testInput) == 26);

console.log("Part 1: " + countUniqueSegmentDigits(input));

// Part 2

function findByGroupLength(groups, length, digit) {
    const matches = groups.filter(group => group.length == length);

    if(matches.length != 1) {
        throw "Error finding match for " + digit + ": " + matches;
    }

    return matches[0];
}

function findBySubsetInclusion(groups, subset, digit) {
    const matches = groups.filter(function(group) {
        let isMatch = true;
        
        subset.split('').forEach(function(ch) {
            if(!group.includes(ch)) {
                isMatch = false;
                return;
            }
        });

        return isMatch;
    });

    if(matches.length != 1) {
        throw "Error finding match for " + digit + ": " + matches;
    }

    return matches[0];
}

function findBySubsetExclusion(groups, subset, digit) {
    const matches = groups.filter(function(group) {
        let includedCount = 0;
        
        subset.split('').forEach(function(ch) {
            if(group.includes(ch)) {
                includedCount++;
            }
        });

        return includedCount != subset.length;
    });

    if(matches.length != 1) {
        throw "Error finding match for " + digit + ": " + matches;
    }

    return matches[0];
}

function findBySupersetInclusion(groups, superset, digit) {
    const matches = groups.filter(function(group) {
        let isMatch = true;

        group.split('').forEach(function(ch) {
            if(!superset.includes(ch)) {
                isMatch = false;
                return;
            }
        });

        return isMatch;
    });

    if(matches.length != 1) {
        throw "Error finding match for " + digit + ": " + matches;
    }

    return matches[0];
}

function mapSegmentGroups(groups) {
    mappings = {}

    // 1, 4, 7, and 8 can be deduced by group length
    mappings[1] = findByGroupLength(groups, 2, 1);
    groups.splice(groups.indexOf(mappings[1]), 1);

    mappings[4] = findByGroupLength(groups, 4, 4);
    groups.splice(groups.indexOf(mappings[4]), 1);

    mappings[7] = findByGroupLength(groups, 3, 7);
    groups.splice(groups.indexOf(mappings[7]), 1);

    mappings[8] = findByGroupLength(groups, 7, 8);
    groups.splice(groups.indexOf(mappings[8]), 1);

    // 3 is the only 5-segment digit to include all of 1
    mappings[3] = findBySubsetInclusion(groups.filter(group => group.length == 5), mappings[1], 3);
    groups.splice(groups.indexOf(mappings[3]), 1);

    // 6 is the only 6-segment digit to NOT include all of 1
    mappings[6] = findBySubsetExclusion(groups.filter(group => group.length == 6), mappings[1], 6);
    groups.splice(groups.indexOf(mappings[6]), 1);

    // 9 is the only remaining 6-segment digit to include all of 3
    mappings[9] = findBySubsetInclusion(groups.filter(group => group.length == 6), mappings[3], 9);
    groups.splice(groups.indexOf(mappings[9]), 1);

    // 0 is the only remaining 6-segment digit
    mappings[0] = findByGroupLength(groups, 6, 0);
    groups.splice(groups.indexOf(mappings[0]), 1);
    
    // 5 is the only remaining 5-segment digit to be completely included in 6
    mappings[5] = findBySupersetInclusion(groups.filter(group => group.length == 5), mappings[6], 5);
    groups.splice(groups.indexOf(mappings[5]), 1);

    // 2 is the only remaining digit
    mappings[2] = groups[0];
    
    return mappings
}

function decodeDigits(digits, mappings) {
    decoded = ""

    digits.forEach(function(digit) {
        sortedDigit = digit.split('').sort().join();

        for(let k in mappings) {
            sortedMapping = mappings[k].split('').sort().join();
            
            if(sortedDigit == sortedMapping) {
                decoded += k;
            }
        }
    });
                   
    return decoded;
}

function outputSum(input) {
    let sum = 0;

    input.forEach(function(line) {
        const split = line.split(" | ");

        const segmentGroups = split[0].split(" ");
        const digits = split[1].split(" ");

        const mappings = mapSegmentGroups(segmentGroups);

        sum += parseInt(decodeDigits(digits, mappings));
    });

    return sum;
}

assert(outputSum(testInput) == 61229);

console.log("Part 2: " + outputSum(input));
