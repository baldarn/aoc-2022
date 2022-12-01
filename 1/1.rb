input = File.read('input')

# question 1
calories_per_elf = input.split("\n\n")
calories_sum_per_elf = calories_per_elf.map { |x| x.split("\n").map(&:to_i).sum }

elf_with_the_most_calories = calories_sum_per_elf.max

puts elf_with_the_most_calories

# question 2

sum_of_the_3_elfs_with_the_most_calories = calories_sum_per_elf.sort.last(3).sum

puts sum_of_the_3_elfs_with_the_most_calories
