input = File.read('input')

wait_time = 0

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

def paint(coordinates, file_name)
  return if coordinates.empty?
  max_x = coordinates.map(&:first).map(&:abs).max
  max_y = coordinates.map(&:last).map(&:abs).max
  normalized = coordinates.map { |x,y| [x+max_x, y+max_y] }
  max_x_normalized = max_x * 2
  max_y_normalized = max_y * 2

  map = (0...max_x_normalized).map { |x| (0...max_y_normalized).map{ |y| false } }
  map = normalized.reduce(map) do |mem, c|
    mem[c.first] ||= []
    mem[c.first][c.last] = true
    mem
  end
  File.open("#{file_name}.txt", "w+") do |f|
    map.each do |row| 
      visual = row.map { |v| v ? "*" : " " }
      f.puts(visual.join(""))
    end
  end
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

paint(space_where_tails_was, "rope")

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
      # puts body_coordinates.map { |c| c.join(':') }.join(' ')
    end
  end

  if direction == "L"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0] - 1, body_coordinates[0][1]]
      # puts body_coordinates.map { |c| c.join(':') }.join(' ')
    end
  end

  if direction == "D"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0], body_coordinates[0][1] - 1]
      # puts body_coordinates.map { |c| c.join(':') }.join(' ')
    end
  end

  if direction == "U"
    (0...motion).each do 
      body_coordinates[0] = [body_coordinates[0][0], body_coordinates[0][1] + 1]
      # puts body_coordinates.map { |c| c.join(':') }.join(' ')
    end
  end

  (0...motion).each do 
    neck_coordinates.each.with_index do |neck, i|
      if tail_is_distant?(body_coordinates[i], neck)
        x = body_coordinates[i][0] < neck[0] ? neck[0] - 1 : body_coordinates[i][0] > neck[0] ? neck[0] + 1 : neck[0]
        y = body_coordinates[i][1] < neck[1] ? neck[1] - 1 : body_coordinates[i][1] > neck[1] ? neck[1] + 1 : neck[1]
        body_coordinates[i + 1] = [x,y]
      end
    end
    
    if tail_is_distant?(body_coordinates.last, tail_coordinates)
      x = body_coordinates.last[0] < tail_coordinates[0] ? tail_coordinates[0] - 1 : body_coordinates.last[0] > tail_coordinates[0] ? tail_coordinates[0] + 1 : tail_coordinates[0]
      y = body_coordinates.last[1] < tail_coordinates[1] ? tail_coordinates[1] - 1 : body_coordinates.last[1] > tail_coordinates[1] ? tail_coordinates[1] + 1 : tail_coordinates[1]
      tail_coordinates = [x,y]
      space_where_tails_was << tail_coordinates
    end
  end

  paint(space_where_tails_was, "long_in_progress")
  sleep wait_time
end

puts space_where_tails_was.uniq.size

paint(space_where_tails_was, "long_rope")
