package main

import (
	"fmt"
	"math"
	"strconv"
	"strings"
)

func main() {
	lines := ReadInput("day-13-input.txt")

	target, err := strconv.Atoi(lines[0])

	if err != nil {
		panic(err)
	}

	fmt.Println(target)

	minDiff := math.MaxInt32
	minDiffBusId := math.MaxInt32

	for _, busId := range strings.Split(lines[1], ",") {
		if busId == "x" {
			continue
		}

		busId, err := strconv.Atoi(busId)

		if err != nil {
			panic(err)
		}

		closest := (target / busId) * busId + busId
		diff := closest - target

		if diff < minDiff {
			minDiff = diff
			minDiffBusId = busId
		}
	}

	product := minDiff * minDiffBusId

	fmt.Println("Product of bus ID and minutes (part 1):", product)
}
