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

# question 2

space_where_tails_was = [[0,0]]

tail_coordinates = [0,0]
body_coordinates = [[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0],[0,0]]

steps.each do |s|
  direction = s[0]
  motion = s[1].to_i

  neck_coordinates = body_coordinates.slice(1...body_coordinates.size)

  if direction == "R"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0] + 1, body_coordinates[0][1]]
      neck_coordinates.each.with_index do |neck, i|
        if tail_is_distant?(body_coordinates[0], neck)
          if tail_is_distant_diagonally?(body_coordinates[0], neck)
            body_coordinates[i + 1] = [neck[0] + 1, body_coordinates[0][1]]
          else
            body_coordinates[i + 1] = [neck[0] + 1, neck[1]]
          end
        end
      end
      
      if tail_is_distant?(body_coordinates.last, tail_coordinates)
        if tail_is_distant_diagonally?(body_coordinates.last, tail_coordinates)
          tail_coordinates = [tail_coordinates[0] + 1, body_coordinates.last[1]]
        else
          tail_coordinates = [tail_coordinates[0] + 1, tail_coordinates[1]]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "L"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0] - 1, body_coordinates[0][1]]
      neck_coordinates.each.with_index do |neck, i|
        if tail_is_distant?(body_coordinates[0], neck)
          if tail_is_distant_diagonally?(body_coordinates[0], neck)
            body_coordinates[i + 1] = [neck[0] - 1, body_coordinates[0][1]]
          else
            body_coordinates[i + 1] = [neck[0] - 1, neck[1]]
          end
        end
      end
      
      if tail_is_distant?(body_coordinates.last, tail_coordinates)
        if tail_is_distant_diagonally?(body_coordinates.last, tail_coordinates)
          tail_coordinates = [tail_coordinates[0] - 1, body_coordinates.last[1]]
        else
          tail_coordinates = [tail_coordinates[0] - 1, tail_coordinates[1]]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "D"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0], body_coordinates[0][1] - 1]
      neck_coordinates.each.with_index do |neck, i|
        if tail_is_distant?(body_coordinates[0], neck)
          if tail_is_distant_diagonally?(body_coordinates[0], neck)
            body_coordinates[i + 1] = [body_coordinates[0][0], neck[1]- 1]
          else
            body_coordinates[i + 1] = [neck[0], neck[1] - 1]
          end
        end
      end
      
      if tail_is_distant?(body_coordinates.last, tail_coordinates)
        if tail_is_distant_diagonally?(body_coordinates.last, tail_coordinates)
          tail_coordinates = [body_coordinates.last[0], tail_coordinates[1] - 1]
        else
          tail_coordinates = [tail_coordinates[0], tail_coordinates[1] - 1]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end

  if direction == "U"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0], body_coordinates[0][1] + 1]
      neck_coordinates.each.with_index do |neck, i|
        if tail_is_distant?(body_coordinates[0], neck)
          if tail_is_distant_diagonally?(body_coordinates[0], neck)
            body_coordinates[i + 1] = [body_coordinates[0][0], neck[1]+ 1]
          else
            body_coordinates[i + 1] = [neck[0], neck[1] + 1]
          end
        end
      end
      
      if tail_is_distant?(body_coordinates.last, tail_coordinates)
        if tail_is_distant_diagonally?(body_coordinates.last, tail_coordinates)
          tail_coordinates = [body_coordinates.last[0], tail_coordinates[1] + 1]
        else
          tail_coordinates = [tail_coordinates[0], tail_coordinates[1] + 1]
        end
        space_where_tails_was << tail_coordinates
      end
    end
  end
end

puts space_where_tails_was.uniq.size
