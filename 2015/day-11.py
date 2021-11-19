input = "vzbxkghb"

### Part 1

# Convert char to ordinal, increment, convert back to char
def next_char(current):
    return chr(((ord(current) - 97 + 1) % 26) + 97)

def has_increasing_straight(pw):
    for i in range(0, len(pw) - 2):
        if ord(pw[i]) == ord(pw[i+1]) - 1 == ord(pw[i+2]) - 2:
            return True
    
    return False

def has_blacklisted_letter(pw):
    if 'i' in pw or 'o' in pw or 'l' in pw:
        return True

    return False

def has_two_pairs(pw):
    count = 0

    i = 0

    while i < len(pw) - 1:
        if pw[i] == pw[i+1]:
            count += 1

            if count == 2:
                return True

            i += 1

        i += 1
    
    return False

def pw_is_valid(pw):
    return (has_increasing_straight(pw)
            and not has_blacklisted_letter(pw)
            and has_two_pairs(pw))

def next_candidate_pw(current):
    split = list(current)

    i = len(split) - 1

    while i >= 0:
        split[i] = next_char(split[i])

        # Skip blacklisted letters
        if split[i] in ['i', 'o', 'l']:
            split[i] = next_char(split[i])
        
        if not split[i] == 'a':
            break
        
        i -= 1

    return "".join(split)

def next_valid_pw(current):
    pw = next_candidate_pw(current)

    while not pw_is_valid(pw):
        pw = next_candidate_pw(pw)

    return pw

assert next_candidate_pw("xx") == "xy"
assert next_candidate_pw("xz") == "ya"
assert has_increasing_straight("abc") == True
assert has_increasing_straight("hijklmmn") == True
assert has_blacklisted_letter("hijklmmn") == True
assert has_two_pairs("hijklmmn") == False
assert has_increasing_straight("abbceffg") == False
assert has_blacklisted_letter("abbceffg") == False
assert has_two_pairs("abbceffg") == True
assert next_valid_pw("abcdefgh") == "abcdffaa"
assert next_valid_pw("ghijklmn") == "ghjaabcc"

next_pw = next_valid_pw(input)

print("Part 1: " + next_pw)

### Part 2

print("Part 1: " + next_valid_pw(next_pw))
