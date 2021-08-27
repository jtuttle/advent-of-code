require 'pry-byebug'
class IntCodeCpu
  attr_reader :input, :output
  
  def initialize(ints, verbose = false)
    @ints = ints
    @verbose = verbose

    @index = 0
    @relative_base = 0
    @halted = false

    @input = []
    @output = []
  end

  def run(input = [])
    @input.concat(input)

    log(@ints.join(','))
    
    while true
      index_value = @ints[@index]

      opcode = index_value % 100
      param_modes = index_value / 100

      case opcode
      when 1
        add(param_modes)
        @index += 4
      when 2
        multiply(param_modes)
        @index += 4
      when 3
        if @input.empty?
          log("(3) NO INPUT")
          break
        end
        
        read_input(param_modes)
        @index += 2
      when 4
        @output << write_output(param_modes)
        @index += 2
      when 5
        @index = jump_if_true(param_modes)
      when 6
        @index = jump_if_false(param_modes)
      when 7
        less_than(param_modes)
        @index += 4
      when 8
        equals(param_modes)
        @index += 4
      when 9
        adjust_relative_base(param_modes)
        @index += 2
      when 99
        log("(99) HALT")
        
        @halted = true
        
        break
      else
        raise StandardError.new("Invalid opcode: #{opcode}")
      end
    end

    @output
  end

  def halted?
    @halted
  end

  private

  def value_for_mode(value, mode)
    case mode
    when 0
      @ints[value] || 0
    when 1
      value
    when 2
      @ints[value + @relative_base] || 0
    else
      raise StandardError.new("Invalid mode: #{mode}")
    end
  end


  def value_for_write_mode(value, mode)
    case mode
    when 0
      value
    when 2
      value + @relative_base
    else
      raise StandardError.new("Invalid write mode: #{mode}")
    end
  end
  
  def log(msg)
    puts "[#{@index}] - #{msg}" if @verbose
  end

  # opcode 1
  def add(param_modes)
    instruction = @ints[@index...@index+4]
    
    operand_1 = value_for_mode(instruction[1], param_modes % 10)
    operand_2 = value_for_mode(instruction[2], param_modes / 10 % 10)
    destination = value_for_write_mode(instruction[3], param_modes / 100 % 10)

    log("(1) - [#{instruction.join(',')}] - #{operand_1} + #{operand_2} => #{destination}")

    @ints[destination] = operand_1 + operand_2
  end

  # opcode 2
  def multiply(param_modes)
    instruction = @ints[@index...@index+4]

    operand_1 = value_for_mode(instruction[1], param_modes % 10)
    operand_2 = value_for_mode(instruction[2], param_modes / 10 % 10)
    destination = value_for_write_mode(instruction[3], param_modes / 100 % 10)

    log("(2) - [#{instruction.join(',')}] - #{operand_1} * #{operand_2} => #{destination}")

    @ints[destination] = operand_1 * operand_2
  end

  # opcode 3
  def read_input(param_modes)
    instruction = @ints[@index...@index + 2]

    input = @input.shift
    destination = value_for_write_mode(instruction[1], param_modes % 10)

    log("(3) - [#{instruction.join(',')}] - #{input} => #{destination}")

    @ints[destination] = input
  end

  # opcode 4
  def write_output(param_modes)
    instruction = @ints[@index...@index + 2]
    
    value = value_for_mode(instruction[1], param_modes % 10)

    log("(4) - [#{instruction.join(',')}] - #{value} => OUTPUT")
    
    value
  end

  # opcode 5
  def jump_if_true(param_modes)
    instruction = @ints[@index...@index + 3]
    
    condition = value_for_mode(instruction[1], param_modes % 10)

    if condition != 0
      new_index = value_for_mode(instruction[2], param_modes / 10 % 10)
      
      log("(5) - [#{instruction.join(',')}] - JUMP => #{new_index}")

      new_index
    else
      log("(5) - [#{instruction.join(',')}] - NO JUMP")
      
      @index + 3
    end
  end

  # opcode 6
  def jump_if_false(param_modes)
    instruction = @ints[@index...@index + 3]
    
    condition = value_for_mode(instruction[1], param_modes % 10)
    
    if condition == 0
      new_index = value_for_mode(instruction[2], param_modes / 10 % 10)

      log("(6) - [#{instruction.join(',')}] - JUMP => #{new_index}")
      
      new_index
    else
      log("(6) - [#{instruction.join(',')}] - NO JUMP")
      
      @index + 3
    end
  end

  # opcode 7
  def less_than(param_modes)
    instruction = @ints[@index...@index + 4]
    
    param_1 = value_for_mode(instruction[1], param_modes % 10)
    param_2 = value_for_mode(instruction[2], param_modes / 10 % 10)
    destination = value_for_write_mode(instruction[3], param_modes / 100 % 10)
    value = (param_1 < param_2 ? 1 : 0)

    log("(7) - [#{instruction.join(',')}] - #{value} => #{destination}")

    @ints[destination] = value
  end

  # opcode 8
  def equals(param_modes)
    instruction = @ints[@index...@index + 4]
    
    param_1 = value_for_mode(instruction[1], param_modes % 10)
    param_2 = value_for_mode(instruction[2], param_modes / 10 % 10)
    destination = value_for_write_mode(instruction[3], param_modes / 100 % 10)
    value = (param_1 == param_2 ? 1 : 0)

    log("(8) - [#{instruction.join(',')}] - #{value} => #{destination}")
    
    @ints[destination] = value
  end

  # opcode 9
  def adjust_relative_base(param_modes)
    instruction = @ints[@index...@index + 2]
    
    adjustment = value_for_mode(instruction[1], param_modes % 10)

    log("(9) - [#{instruction.join(',')}] - #{@relative_base} + #{adjustment} => RELATIVE_BASE")

    @relative_base += adjustment
  end                      
end
