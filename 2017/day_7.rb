test_input = [
  "pbga (66)",
  "xhth (57)",
  "ebii (61)",
  "havc (66)",
  "ktlj (57)",
  "fwft (72) -> ktlj, cntj, xhth",
  "qoyq (66)",
  "padx (45) -> pbga, havc, qoyq",
  "tknk (41) -> ugml, padx, fwft",
  "jptl (61)",
  "ugml (68) -> gyxo, ebii, jptl",
  "gyxo (61)",
  "cntj (57)",
]

input = File.readlines("input/day_7")

Struct.new("Program", :name, :weight, :parent, :children, :branch_weight)

def create_tree(input)
  # loop through file once to just create program structs
  programs = {}
  
  input.each do |line|
    program_data = line.split("->")[0]
    name, weight = program_data.split(" ")

    program = Struct::Program.new(name, weight[1...-1].to_i, nil, [], 0)
    programs[name] = program
  end
    
  # loop through again to hook them all up and create a tree
  input.each do |line|
    program_data, children = line.split("->")
    name, weight = program_data.split(" ")

    if !children.nil?
      children.split(",").map(&:strip).each do |child_name|
        programs[name].children << programs[child_name]
        programs[child_name].parent = programs[name]
      end
    end
  end

  # find and return the parent
  program = programs.values[0]

  while !program.parent.nil?
    program = program.parent
  end

  program
end

def find_imbalance(node)
  node.children.each do |child|
    answer = find_imbalance(child)

    # Short-circuit remaining calls if an answer has been found.
    if !answer.nil?
      return answer
    end
  end

  # Note: this would not work when an imbalance was found with only two
  # children, but fortunately that's not the case in this puzzle.
  if !node.children.empty?
    child_weights = node.children.map(&:branch_weight)

    # An imbalance is found
    if child_weights.uniq.count != 1
      partitioned_child_weights =
        child_weights.partition { |i| child_weights.count(i) == 1 }

      bad_weight = partitioned_child_weights[0][0]
      bad_child = node.children.find { |child| child.branch_weight == bad_weight }

      weight_diff = partitioned_child_weights[1][0] - partitioned_child_weights[0][0]
      
      return bad_child.weight + weight_diff
    end
  end

  node.branch_weight = node.weight + node.children.map(&:branch_weight).sum

  nil
end

puts "*** Part One"

test_root = create_tree(test_input)
puts test_root.name

root = create_tree(input)
puts "Answer: #{root.name}"

puts "*** Part Two"

puts find_imbalance(test_root)
puts "Answer: #{find_imbalance(root)}"



# 1990 is too high
