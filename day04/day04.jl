
# The description for this problem is too long to write it here
# go and check https://adventofcode.com/2020/day/4

# The ides is to read all lines, also blank ones, and for each
# group of lines without blank ones, split the strings and push
# them to a Dict as key-value pairs. Whenever we find a blank line
# we push the DIct into an array which keep tracks of all passports.
# With this datastructure it should then be easy query whatever we want.

# readlines also returns blank lines
raw_passports = readlines("input.txt")
# add a final blank line to simplify the parsing loop
push!(raw_passports,"")

passports = Dict{String,String}[]
passport = Dict{String,String}()

# loop over lines
for line in raw_passports

  global passport
  # check if the line contains information
  if length(line) > 0
    # split elements separated by blank space
    field_value_pairs = split(line,' ')
    # each entry is now a field:value pair
    for field_value_pair in field_value_pairs
      field,value = split(field_value_pair,':')
      push!(passport,field=>value)
    end
  # it is a blank line
  else
    push!(passports,passport)
    passport = Dict{String,String}()
  end

end

valid_passports = 0

for passport in passports
  if length(passport) == 8 || (length(passport) == 7 && !haskey(passport,"cid"))
    global valid_passports += 1
  end
end

println("There are $valid_passports valid passports out of $(length(passports))")




