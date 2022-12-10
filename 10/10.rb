input = File.read('input')

# input = File.read('test')

# question 1

moves = input.split("\n")

register = Array.new(240, 1)
cycle = 0
line = 0

while cycle < 240
  op, num = moves[line].split
  num = num.to_i if !num.nil?
  line += 1

  case op
  when 'noop'
    register[cycle + 1] = register[cycle]
    cycle += 1
  when 'addx'
    new_val = register[cycle] + num
    register[cycle + 1] = register[cycle]
    register[cycle + 2] = new_val
    cycle += 2
  end
end

def signal_strength(num, register)
  num * register[num - 1]
end

power = register.at(20 - 1) * 20 + register.at(60 - 1) * 60 + register.at(100 - 1) * 100 + register.at(140 - 1) * 140 + register.at(180 - 1) * 180 + register.at(220 - 1) * 220

puts power

# question 2

6.times.each do |row|
  40.times.each do |col|
    center = register[row * 40 + col]
    sprite = (center - 1)..(center + 1)
    print sprite.cover?(col) ? '#' : '.'
  end
  puts
end
