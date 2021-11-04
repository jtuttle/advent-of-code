from typing import NamedTuple
import itertools

with open('day-09-test.txt') as f:
    test_input = list(map(str.strip, f.readlines()))

with open('day-09.txt') as f:
    input = list(map(str.strip, f.readlines()))

### Part 1

class Edge(NamedTuple):
    other: str
    distance: int

def build_graph(routes):
    graph = {}
    
    for route in routes:
        locations, distance = route.split(" = ")
        distance = int(distance)
        
        start, finish = locations.split(" to ")

        if start not in graph: graph[start] = []

        graph[start].append(Edge(finish, distance))

        if finish not in graph: graph[finish] = []

        graph[finish].append(Edge(start, distance))

    return(graph)

# Brute-force solution for TSP
# Return all distances so that result can be used for both Part 1 & 2
def route_distances(graph):
    perms = list(itertools.permutations(graph.keys()))
    distances = []

    for perm in perms:
        total_dist = 0
        
        for i in range(0, len(perm) - 1):
            start = perm[i]
            finish = perm[i+1]

            edge = next(x for x in graph[start] if x.other == finish)

            total_dist += edge.distance

        distances.append(total_dist)

    distances.sort()
        
    return distances

assert route_distances(build_graph(test_input))[0] == 605

graph = build_graph(input)
distances = route_distances(graph)

print("Part 1: " + str(distances[0]))

### Part 2

print("Part 2: " + str(distances[-1]))
