input = File.read('input')

# question 1

signal = input.scan(/\w/)


start_of_packet = signal.reduce({found: false, buffer: [], count: 0}) do |mem, s| 
  
  mem[:buffer].push(s)
  if(!mem[:found])
    mem[:count] = mem[:count] + 1  
  end

  if(mem[:buffer].size > 4)
    mem[:buffer] = mem[:buffer].drop(1)
  end

  if(!mem[:found] && mem[:buffer].size == 4)
    puts "buffer #{mem[:buffer]}"
    mem[:found] = (0..3).select { |i| mem[:buffer].count(mem[:buffer][i]) > 1 }.empty?
  end
  mem
end

puts start_of_packet[:count]

# question 2

start_of_signal = signal.reduce({found: false, buffer: [], count: 0}) do |mem, s| 
  
  mem[:buffer].push(s)
  if(!mem[:found])
    mem[:count] = mem[:count] + 1  
  end

  if(mem[:buffer].size > 14)
    mem[:buffer] = mem[:buffer].drop(1)
  end

  if(!mem[:found] && mem[:buffer].size == 14)
    puts "buffer #{mem[:buffer]}"
    mem[:found] = (0..14).select { |i| mem[:buffer].count(mem[:buffer][i]) > 1 }.empty?
  end
  mem
end

puts start_of_signal[:count]
