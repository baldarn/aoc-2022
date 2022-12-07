# question 1

=begin
  { 
    dir1: { sub_dirs: ["",""], files: [{ name: "", size: 0 }] },
    dir2: { sub_dirs: [], files: [{ name: "", size: 0 }] },
    ...
  }
=end

require 'json'

current_path = ""
file_system = {}

File.readlines("input").each do |line|
  if(line.include?("$"))
    # command section
    command = line.split(" ")[1]
    arg = nil
    if command == "cd" 
      arg = line.split(" ")[2]
      if arg == "/"
        current_path = "/"
      elsif arg == ".."
        splitted = current_path.split("/")
        paths = splitted.slice(0, splitted.size - 1) || []
        current_path = paths.join("/") + "/"
        if current_path == ""
          current_path = "/"
        end
      else
        current_path += "#{arg}/"
      end
    end
  else
    # output section
    size_or_dir = line.split(" ")[0]
    name = line.split(" ")[1]

    dir = file_system["#{current_path}"] || { sub_dirs: [], files: [] }

    if size_or_dir == "dir"
      # is a number
      dir[:sub_dirs] << current_path + name + "/"
    else
      # is a number
      dir[:files] << { name: name, size: size_or_dir.to_i }  
    end
    file_system["#{current_path}"] = dir
  end
end

def populate_sizes(path, fs)
  size = 0
  if path[:sub_dirs] != []
    sub_dirs = path[:sub_dirs].map { |sd| fs[sd] } 
    size = sub_dirs.map { |sub_dir| populate_sizes(sub_dir, fs) }.sum
  end
  path[:size] = path[:files].map { |f| f[:size] }.sum + size
  path[:size]
end

# calculate sizes
populate_sizes(file_system["/"], file_system)

files_smaller_than_100000 = file_system.to_a.select {|_,v| v[:size] <= 100000 }.map { |_,v| v[:size] }.sum

puts files_smaller_than_100000

# question 2

total_space = 70000000
needed_space = 30000000

used_space = total_space - file_system["/"][:size]
unused_space = needed_space - used_space

to_delete_dir = file_system.to_a.sort_by { |_,v| v[:size] }.find { |_,v| v[:size] >= unused_space }

puts to_delete_dir[:size]
