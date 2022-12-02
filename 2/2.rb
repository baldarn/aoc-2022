input = File.read('input')

# question 1
strategies = input.split("\n")

# A rock      | X rock
# B paper     | Y paper
# C scissors  | Z scissors

my_total_score = strategies.reduce(0) do |mem, s|
  opponent_move = s.split(' ').first
  my_move = s.split(' ').last

  puts "#{opponent_move} : #{my_move}"

  if(opponent_move == 'A')
    if(my_move == 'X')
      mem += 1 + 3
    end
    if(my_move == 'Y')
      mem += 2 + 6
    end
    if(my_move == 'Z')
      mem += 3 + 0
    end
  end

  if(opponent_move == 'B')
    if(my_move == 'X')
      mem += 1 + 0
    end
    if(my_move == 'Y')
      mem += 2 + 3
    end
    if(my_move == 'Z')
      mem += 3 + 6
    end
  end

  if(opponent_move == 'C')
    if(my_move == 'X')
      mem += 1 + 6
    end
    if(my_move == 'Y')
      mem += 2 + 0
    end
    if(my_move == 'Z')
      mem += 3 + 3
    end
  end

  mem
end

puts my_total_score

# question 2

# A rock      | X lose
# B paper     | Y draw
# C scissors  | Z win


my_real_total_score = strategies.reduce(0) do |mem, s|
  opponent_move = s.split(' ').first
  outcome = s.split(' ').last

  puts "#{opponent_move} : #{outcome}"

  if(opponent_move == 'A')
    if(outcome == 'Z')
      mem += 2 + 6
    end
    if(outcome == 'Y')
      mem += 1 + 3
    end
    if(outcome == 'X')
      mem += 3 + 0
    end
  end

  if(opponent_move == 'B')
    if(outcome == 'Z')
      mem += 3 + 6
    end
    if(outcome == 'Y')
      mem += 2 + 3
    end
    if(outcome == 'X')
      mem += 1 + 0
    end
  end

  if(opponent_move == 'C')
    if(outcome == 'Z')
      mem += 1 + 6
    end
    if(outcome == 'Y')
      mem += 3 + 3
    end
    if(outcome == 'X')
      mem += 2 + 0
    end
  end

  mem
end

puts my_real_total_score
