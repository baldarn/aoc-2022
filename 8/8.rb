input = File.read('input')

# input = File.read('test')

# question 1

map = input.split("\n").map { |r| r.scan(/\w/).map(&:to_i) }

visible_trees_map = []

def check_visibility(rows, i, visible_trees_row)
  tallest_tree_found = -1

  rows.each.with_index do |tree_height, j|
    is_visible = false
    if tree_height > tallest_tree_found
      tallest_tree_found = tree_height
      is_visible = true
    end
    
    visible_trees_row = [] if visible_trees_row.nil?

    if visible_trees_row[j].nil? || visible_trees_row[j] == false
      visible_trees_row[j] = is_visible
    end
  end

  visible_trees_row
end

map.each.with_index do |rows, i|
  visible_trees_map[i] = check_visibility(rows, i, visible_trees_map[i])
  visible_trees_map[i] = check_visibility(rows.reverse, i, visible_trees_map[i].reverse).reverse
end

visible_trees_map = visible_trees_map.transpose.map(&:reverse)

map.transpose.map(&:reverse).each.with_index do |rows, i|
  visible_trees_map[i] = check_visibility(rows, i, visible_trees_map[i])
  visible_trees_map[i] = check_visibility(rows.reverse, i, visible_trees_map[i].reverse).reverse
end

# return to initial rotation
visible_trees_map = visible_trees_map
  .transpose
  .map(&:reverse)
  .transpose
  .map(&:reverse)
  .transpose
  .map(&:reverse)

visible_trees = visible_trees_map.flatten.select { |is_visible| is_visible }.count

# draw to see with eyes :)
File.open("map.txt", "w+") do |f|
  visible_trees_map.map do |row| 
    to_see = row.map { |x| x ? "x" : "o" }
    f.puts(to_see.join(' ')) 
  end
end

puts visible_trees

# question 2

scenic_score_map = []

def check_score(rows, i, scenic_score_row, direction = :horizontal)

  scenic_score_row = [] if scenic_score_row.nil?

  rows.each.with_index do |tree_height, j|
    
    scenic_score_row[j] = {} if scenic_score_row[j].nil?

    before_sight = rows.slice(0...j) || []
    after_sight = rows.slice(j+1...rows.size) || []

    index_taller_tree_before = before_sight.reverse.find_index { |x| x >= tree_height }
    trees_in_sight_before = index_taller_tree_before ? index_taller_tree_before + 1 : before_sight.size
    if direction == :horizontal
      scenic_score_row[j][:left] = trees_in_sight_before || 1
    else
      scenic_score_row[j][:up] = trees_in_sight_before || 1
    end

    index_taller_tree_after = after_sight.find_index { |x| x >= tree_height }
    trees_in_sight_after = index_taller_tree_after ? index_taller_tree_after + 1 : after_sight.size
    if direction == :horizontal
      scenic_score_row[j][:right] = trees_in_sight_after || 1
    else
      scenic_score_row[j][:down] = trees_in_sight_after || 1
    end

    # puts "#{i} #{j} tree_height #{tree_height} before_sight #{before_sight} after_sight #{after_sight} scenic_score #{scenic_score_row[j]}"
  end

  scenic_score_row
end

map.each.with_index do |rows, i|
  scenic_score_map[i] = check_score(rows, i, scenic_score_map[i])
end

scenic_score_map = scenic_score_map.transpose.map(&:reverse)

map.transpose.map(&:reverse).each.with_index do |rows, i|
  scenic_score_map[i] = check_score(rows, i, scenic_score_map[i], :vertical)
end

# return to initial rotation
scenic_score_map = scenic_score_map
  .transpose
  .map(&:reverse)
  .transpose
  .map(&:reverse)
  .transpose
  .map(&:reverse)

# draw to see with eyes :)
File.open("scenic_map.txt", "w+") do |f|
  scenic_score_map.map do |row| 
    to_see = row.map { |x| x[:left] * x[:right] * x[:up] * x[:down] }
    f.puts(to_see.join(' ')) 
  end
end

tree_scenic_score = scenic_score_map.flatten.map { |x| x[:left] * x[:right] * x[:up] * x[:down] }
 
puts tree_scenic_score.max

