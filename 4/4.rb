input = File.read('input')

# question 1

assignements = input.split("\n")

overlapping = assignements.filter do |pair|
  first = pair.split(',')[0]
  second = pair.split(',')[1]

  first_interval = (first.split('-')[0]..first.split('-')[1]).to_a
  second_interval = (second.split('-')[0]..second.split('-')[1]).to_a

  overlap = (first_interval & second_interval)

  ret = false
  if overlap == first_interval || overlap == second_interval
    ret = true
  end
  ret
end

puts overlapping.count
