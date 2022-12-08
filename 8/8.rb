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
    f.puts(to_see.join('')) 
  end
end

puts visible_trees

# question 2

