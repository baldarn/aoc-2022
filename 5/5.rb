=begin
        [C] [B] [H]                
[W]     [D] [J] [Q] [B]            
[P] [F] [Z] [F] [B] [L]            
[G] [Z] [N] [P] [J] [S] [V]        
[Z] [C] [H] [Z] [G] [T] [Z]     [C]
[V] [B] [M] [M] [C] [Q] [C] [G] [H]
[S] [V] [L] [D] [F] [F] [G] [L] [F]
[B] [J] [V] [L] [V] [G] [L] [N] [J]
 1   2   3   4   5   6   7   8   9 
=end

input = File.read('input')

# question 1

stack1 = ["W", "P", "G", "Z", "V", "S", "B"].reverse
stack2 = ["F", "Z", "C", "B", "V", "J"].reverse
stack3 = ["C", "D", "Z", "N", "H", "M", "L", "V"].reverse
stack4 = ["B", "J", "F", "P", "Z", "M", "D", "L"].reverse
stack5 = ["H", "Q", "B", "J", "G", "C", "F", "V"].reverse
stack6 = ["B", "L", "S", "T", "Q", "F", "G"].reverse
stack7 = ["V", "Z", "C", "G", "L"].reverse
stack8 = ["G", "L", "N"].reverse
stack9 = ["C", "H", "F", "J"].reverse

stacks = []
stacks.push(stack1)
stacks.push(stack2)
stacks.push(stack3)
stacks.push(stack4)
stacks.push(stack5)
stacks.push(stack6)
stacks.push(stack7)
stacks.push(stack8)
stacks.push(stack9)

moves = input.split("\n").map do |move|
    qty = move.split(" ")[1].to_i
    from = move.split(" ")[3].to_i
    to = move.split(" ")[5].to_i
    {qty: qty, from: from, to: to} 
end

moves.each do |m|
    puts "#{m}"
    index_from = m[:from] - 1
    index_to = m[:to] - 1
    qty = m[:qty]
    puts "before #{stacks[index_from]}"
    to_move = (1..qty).map { |_| stacks[index_from].pop }
    puts "after #{stacks[index_from]}"
    puts "to_move #{to_move}"
    puts "before move #{stacks[index_to]}"
    stacks[index_to] += to_move
    puts "after move #{stacks[index_to]}"
end

puts "message: #{stacks.map { |s| s.last }.join('')}"

# question 2

stack1 = ["W", "P", "G", "Z", "V", "S", "B"].reverse
stack2 = ["F", "Z", "C", "B", "V", "J"].reverse
stack3 = ["C", "D", "Z", "N", "H", "M", "L", "V"].reverse
stack4 = ["B", "J", "F", "P", "Z", "M", "D", "L"].reverse
stack5 = ["H", "Q", "B", "J", "G", "C", "F", "V"].reverse
stack6 = ["B", "L", "S", "T", "Q", "F", "G"].reverse
stack7 = ["V", "Z", "C", "G", "L"].reverse
stack8 = ["G", "L", "N"].reverse
stack9 = ["C", "H", "F", "J"].reverse
stacks = []

stacks.push(stack1)
stacks.push(stack2)
stacks.push(stack3)
stacks.push(stack4)
stacks.push(stack5)
stacks.push(stack6)
stacks.push(stack7)
stacks.push(stack8)
stacks.push(stack9)

moves.each do |m|
    puts "#{m}"
    index_from = m[:from] - 1
    index_to = m[:to] - 1
    qty = m[:qty]
    puts "before #{stacks[index_from]}"
    to_move = stacks[index_from].pop(qty)
    puts "after #{stacks[index_from]}"
    puts "to_move #{to_move}"
    puts "before move #{stacks[index_to]}"
    stacks[index_to] += to_move
    puts "after move #{stacks[index_to]}"
end

puts "message: #{stacks.map { |s| s.last }.join('')}"
