
# Given a list of policies and passwords, find how many are valid.
# The policy consists in a min and max number of times a certain character
# has to appear in the password.
# Example:
# 1-3 g: ljgasfs 
# This is a valid password since the letter g appears once and has to appear
# a minimum of one time and a maximum of three times.

using DelimitedFiles

# The idea is to simply loop over the array of passwords, read the policy and
# simply count the characters.

# read the data as an array of strings with space as delimiters
passwords = readdlm("input.txt",' ',String)

# initialize counter of valid passwords
valid = 0

for i = 1:size(passwords,1)
  # first column contains elements like "x-y" where x and y are integers with x < y
  minmax = split(passwords[i,1],'-')
  min = parse(Int,minmax[1])
  max = parse(Int,minmax[2])

  # second column contains elements like "c:" where c is a character
  # the only function is used to make a string of one character to Char
  character = only(chop(passwords[i,2], tail = 1))

  # third column contains the passwords
  occurences = count(==(character),passwords[i,3])

  if min ≤ occurences ≤ max
    global valid += 1
  end
end

println("There are $valid valid passwords out of $(size(passwords,1))")


#--- Part two ---#
println("#--- Part two ---#")

# In part two, the policy is actually difference. What previously were min
# and max, they are now exact positions in the password. At exclusively one
# of these positions, the character of the policy has to appear. If it appears
# twice or zero times, the password is not valid.

# initialize counter of valid passwords
valid = 0

for i = 1:size(passwords,1)
  # first column contains elements like "x-y" where x and y are integers with x < y
  positions = split(passwords[i,1],'-')
  i₁ = parse(Int,positions[1])
  i₂ = parse(Int,positions[2])

  # second column contains elements like "c:" where c is a character
  # the only function is used to make a string of one character to Char
  character = only(chop(passwords[i,2], tail = 1))

  # third column contains the passwords
  occurences = count(==(character),[passwords[i,3][i₁],passwords[i,3][i₂]])

  if occurences == 1
    global valid += 1
  end
end

println("There are $valid valid passwords out of $(size(passwords,1))")




