door_codes = open('data/data_21.txt').read.split("\n")

NUMERIC_KEYPAD_NEIGHBOURS = {
  'A' => [['0', '<'], ['3', '^']],
  '0' => [['A', '>'], ['2', '^']],
  '1' => [['2', '>'], ['4', '^']],
  '2' => [['1', '<'], ['3', '>'], ['5', '^'], ['0', 'v']],
  '3' => [['2', '<'], ['6', '^'], ['A', 'v']],
  '4' => [['5', '>'], ['7', '^'], ['1', 'v']],
  '5' => [['4', '<'], ['6', '>'], ['8', '^'], ['2', 'v']],
  '6' => [['5', '<'], ['9', '^'], ['3', 'v']],
  '7' => [['8', '>'], ['4', 'v']],
  '8' => [['7', '<'], ['9', '>'], ['5', 'v']],
  '9' => [['8', '<'], ['6', 'v']]
}

DIRECTIONAL_KEYPAD_NEIGHBOURS = {
  '<' => [['v', '>']],
  'v' => [['<', '<'], ['>', '>'], ['^', '^']],
  '>' => [['v', '<'], ['A', '^']],
  '^' => [['v', 'v'], ['A', '>']],
  'A' => [['^', '<'], ['>', 'v']]
}

# this method takes a string of instructions and returns all the possible instructions to have this string executed
# it works to type the final codes or to control the remote, the second parameter determines which keypad we're using
def retrieve_possible_instructions_for(string, keypad_neighbours)
  # this method will be performed to find shortest_path from one element of the string to the next one
  # so we'll compute it a number of times equal to the number of elements in the input string
  # At first, a robot will always be on 'A', because it starts on it and it has to press it to apply the instruction at the end of the string
  starting_position = 'A'
  destination = string[0]
  possibilities = {}
  string.length.times do |i|
    # for every single element of the string, we'll perform a bfs to get all the shortest possibilities to get there
    # we'll keep in the queue, the instructions pressed so far (index 0) and the position (index 1)
    instructions_and_position = ['', starting_position]
    queue = [instructions_and_position]
    minimal_size_of_instructions = nil
    character_possibilities = []
    while queue.any?
      element = queue.shift
      # Once we reached the destination once, it determines the shortest paths' number of instructions, so we can fix it
      # Then everytime we reach the destination, we save the path if the number of instructions is still the minimal one
      if element.last == destination
        minimal_size_of_instructions = element.first.length
        # We always have to press 'A' at the end so the robot will actually perform it
        character_possibilities << element.first + 'A' if character_possibilities.empty? || character_possibilities.first.length - 1 == element.first.length
      end
      keypad_neighbours[element.last].each do |nb|
        st = element.first + nb.last
        queue << [st, nb.first] if minimal_size_of_instructions.nil? || st.length <= minimal_size_of_instructions
      end
    end
    # Once we're good, we'll store for every step (every element in the string), the possibilities to have it pressed
    possibilities[i] = character_possibilities
    # then the destination reached becomes the starting position
    starting_position = destination
    # and the destination is the next element of the string
    destination = string[i + 1]
  end
  possibilities
end

CACHE = {}

# this method takes a string and compute the shortest_path to have it, based on which robot has to execute it and the total number of robots
# to do so, it will use the previous method to retrieve the possible instructions for the string
# and then it will call itself to find the number of instructions the next robots will have to do to get there
# We are using a cache for performance issue
def determine_shortest_path_for(string, robot_number, total_number_of_robots, keypad: NUMERIC_KEYPAD_NEIGHBOURS)
  return CACHE[[string, robot_number, total_number_of_robots]] if CACHE[[string, robot_number, total_number_of_robots]]

  shortest_path_length = retrieve_possible_instructions_for(string, keypad).map do |_, possible_instructions_for_string|
    possible_instructions_for_string.map do |possible_instruction_for_string|
      if robot_number < total_number_of_robots
        determine_shortest_path_for(possible_instruction_for_string, robot_number + 1, total_number_of_robots, keypad: DIRECTIONAL_KEYPAD_NEIGHBOURS)
      else
        possible_instruction_for_string.length
      end
    end.min
  end.sum
  CACHE[[string, robot_number, total_number_of_robots]] = shortest_path_length
end

part_2_result = 0
part_1_result= 0

door_codes.each do |door_code|
  part_2_result += determine_shortest_path_for(door_code, 0, 25) * door_code.gsub('A', '').to_i
  part_1_result += determine_shortest_path_for(door_code, 0, 2) * door_code.gsub('A', '').to_i
end

p "Part1: #{part_1_result}"
p "Part2: #{part_2_result}"
