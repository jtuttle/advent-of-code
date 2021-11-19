import re
from functools import reduce

with open('day-15-test.txt') as f:
    test_input = f.readlines()

with open('day-15.txt') as f:
    input = f.readlines()

### Part 1

def parse_ingredients(input):
    ingredients = {}

    for line in input:
        split = re.split(': |, | ', line.strip())

        properties = []

        for i in range(2, len(split), 2):
            properties.append(int(split[i]))

        ingredients[split[0]] = properties
        
    return ingredients

# Recursive function to create every possible cookie w/ the given capacity
def make_cookies(ingredients, total_capacity, remaining_capacity, cookies, amounts = []):
    for i in range(0, remaining_capacity + 1):
        amounts.append(i)

        if len(amounts) == len(ingredients):
            # only choose cookies that total to the capacity
            if sum(amounts) == total_capacity:
                cookie = {}

                for i in range(0, len(ingredients)):
                    # This is relying on dict keys being ordered, which they are
                    # are in python, though relying on this isn't great practice.
                    ingredient = list(ingredients.keys())[i]
                    cookie[ingredient] = amounts[i]
                
                cookies.append(cookie)
        else:
            make_cookies(ingredients, total_capacity, remaining_capacity - i, cookies, amounts)

        amounts.pop()

# Score each property of a cookie individually and return as a list
def score_cookie(cookie, ingredients):
    prop_scores = [0] * 5

    for ingredient in cookie:
        ingredient_scores = [x * cookie[ingredient] for x in ingredients[ingredient]]
        prop_scores = [a + b for a, b in zip(prop_scores, ingredient_scores)]

    # Replace negative scores with zero
    prop_scores = list(map(lambda x: max(0, x), prop_scores))

    return prop_scores

def score_cookies(cookies, ingredients):
    cookie_scores = []

    for cookie in cookies:
        cookie_scores.append(score_cookie(cookie, ingredients))
    
    return cookie_scores

def best_cookie_score(cookie_scores):
    max_score = 0

    for prop_scores in cookie_scores:
        total_score = reduce(lambda x, y: x * y, prop_scores[:-1]) # exclude calories
        max_score = max(total_score, max_score)

    return max_score

CAPACITY = 100

test_ingredients = parse_ingredients(test_input)
test_cookies = []
make_cookies(test_ingredients, CAPACITY, CAPACITY, test_cookies)
test_scores = score_cookies(test_cookies, test_ingredients)

assert best_cookie_score(test_scores) == 62842880

ingredients = parse_ingredients(input)
cookies = []
make_cookies(ingredients, CAPACITY, CAPACITY, cookies)
cookie_scores = score_cookies(cookies, ingredients)

print("Part 1: " + str(best_cookie_score(cookie_scores)))

### Part 2

def best_cookie_score_2(cookie_scores, required_calories):
    max_score = 0

    for prop_scores in cookie_scores:
        total_score = reduce(lambda x, y: x * y, prop_scores[:-1]) # exclude calories

        if prop_scores[-1] == required_calories:
            max_score = max(total_score, max_score)

    return max_score

print("Part 2: " + str(best_cookie_score_2(cookie_scores, 500)))
