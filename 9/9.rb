input = File.read('input')

# question 1

steps = input.split("\n").map { |a| a.split(" ") }

# space of coordinates visited by the tail
space_where_tails_was = [[0,0]]

tail_coordinates = [0,0]
head_coordinates = [0,0]

def tail_is_distant?(head_coordinates, tail_coordinates)
  return true if (head_coordinates[0] - tail_coordinates[0]).abs > 1
  return true if (head_coordinates[1] - tail_coordinates[1]).abs > 1

  return false
end

def tail_is_distant_diagonally?(head_coordinates, tail_coordinates)
  return false if head_coordinates[0] == tail_coordinates[0] || head_coordinates[1] == tail_coordinates[1]

  return true
end


steps.each do |s|
  direction = s[0]
  motion = s[1].to_i

  if direction == "R"
    (0...motion).each do 
      head_coordinates = [head_coordinates[0] + 1, head_coordinates[1]]
      if tail_is_distant?(head_coordinates, tail_coordinates)
        if tail_is_distant_diagonally?(head_coordinates, tail_coordinates)
          tail_coordinates = [tail_coordinates[0] + 1, head_coordinates[1]]
        else
          tail_coordinates = [tail_coordinates[0] + 1, tail_coordinates[1]]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "L"
    (0...motion).each do 
      head_coordinates = [head_coordinates[0] - 1, head_coordinates[1]]
      if tail_is_distant?(head_coordinates, tail_coordinates)
        if tail_is_distant_diagonally?(head_coordinates, tail_coordinates)
          tail_coordinates = [tail_coordinates[0] - 1, head_coordinates[1]]
        else
          tail_coordinates = [tail_coordinates[0] - 1, tail_coordinates[1]]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "D"
    (0...motion).each do 
      head_coordinates = [head_coordinates[0], head_coordinates[1] - 1]
      if tail_is_distant?(head_coordinates, tail_coordinates)
        if tail_is_distant_diagonally?(head_coordinates, tail_coordinates)
          tail_coordinates = [head_coordinates[0], tail_coordinates[1] - 1]
        else
          tail_coordinates = [tail_coordinates[0], tail_coordinates[1] - 1]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "U"
    (0...motion).each do 
      head_coordinates = [head_coordinates[0], head_coordinates[1] + 1]
      if tail_is_distant?(head_coordinates, tail_coordinates)
        if tail_is_distant_diagonally?(head_coordinates, tail_coordinates)
          tail_coordinates = [head_coordinates[0], tail_coordinates[1] + 1]
        else
          tail_coordinates = [tail_coordinates[0], tail_coordinates[1] + 1]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end
end

puts space_where_tails_was.uniq.size
