from typing import NamedTuple
import math

with open('day-14-test.txt') as f:
    test_input = f.readlines()

with open('day-14.txt') as f:
    input = f.readlines()

### Part 1

class Reindeer(NamedTuple):
    name: str
    fly_speed: int
    fly_secs: int
    rest_secs: int

def parse_reindeer(input):
    reindeer = []
    
    for line in input:
        split = line.split()

        reindeer.append(
            Reindeer(
                split[0], int(split[3]), int(split[6]), int(split[-2])
            )
        )
        
    return reindeer

def get_distances(reindeer, secs):
    distances = {}

    for deer in reindeer:
        dist_per_sprint = deer.fly_speed * deer.fly_secs
        time_per_sprint = deer.fly_secs + deer.rest_secs

        sprint_count = math.floor(secs / time_per_sprint)

        remaining_secs = secs - (sprint_count * time_per_sprint)

        dist_last_sprint = deer.fly_speed * min(deer.fly_secs, remaining_secs)
        
        distances[deer.name] = (dist_per_sprint * sprint_count) + dist_last_sprint

    return distances

assert get_distances(parse_reindeer(test_input), 1000)["Comet"] == 1120
assert get_distances(parse_reindeer(test_input), 1000)["Dancer"] == 1056

reindeer = parse_reindeer(input)
distances = get_distances(reindeer, 2503)
winner_dist = max(distances.values())

print("Part 1: " + str(winner_dist))

### Part 2

def get_points(reindeer, secs):
    points = {}

    for deer in reindeer:
        points[deer.name] = 0

    for i in range(1, secs + 1):
        distances = get_distances(reindeer, i)

        max_distance = 0

        for deer in distances:
            max_distance = max(distances[deer], max_distance)

        for deer in distances:
            if distances[deer] == max_distance:
                points[deer] += 1

    return points

assert get_points(parse_reindeer(test_input), 1000)["Comet"] == 312
assert get_points(parse_reindeer(test_input), 1000)["Dancer"] == 689

points = get_points(reindeer, 2503)
winner_points = max(points.values())

print("Part 2: " + str(winner_points))
