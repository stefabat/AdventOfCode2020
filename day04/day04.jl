
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

#--- Part two ---#

println("#--- Part two ---#")

# For part 2 we need to check that every field complies with a set of rules.
# I read again the input file and check the data in the fly. If it is not valid
# I simply do not add it to the passport.

# readlines also returns blank lines
raw_passports = readlines("input.txt")
# add a final blank line to simplify the parsing loop
push!(raw_passports,"")

passports = Dict{String,String}[]
passport = Dict{String,String}()

# function to check if an entry is valid
function isvalid(field,value)
  if field == "byr" && length(value) == 4 && (1920 ≤ parse(Int,value) ≤ 2002)
    return true
  elseif field == "iyr" && length(value) == 4 && (2010 ≤ parse(Int,value) ≤ 2020)
    return true
  elseif field == "eyr" && length(value) == 4 && (2020 ≤ parse(Int,value) ≤ 2030)
    return true
  elseif field == "hgt" && occursin(r"^[0-9]+[cm|in]{2}$",value)
    if (value[end-1:end] == "cm" && (150 ≤ parse(Int,value[1:end-2]) ≤ 193)) ||
       (value[end-1:end] == "in" && ( 59 ≤ parse(Int,value[1:end-2]) ≤  76))
      return true
    else
      return false
    end
  elseif field == "hcl" && occursin(r"^[#][a-z0-9]{6}$",value)
    return true
  elseif field == "ecl" && in(value,["amb","blu","brn","gry","grn","hzl","oth"])
    return true
  elseif field == "pid" && occursin(r"^[0-9]{9}$",value)
    return true
  elseif field == "cid"
    return true
  else
    return false
  end
end


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

      # check validity of field
      if isvalid(field,value)
        push!(passport,field=>value)
      end
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



