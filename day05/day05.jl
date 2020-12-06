
# The description for this problem is too long to write it here
# go and check https://adventofcode.com/2020/day/5

passes = readlines("input.txt")

# takes a string of Fs and Bs as inputs and returns the corresponding integer
function getrow(str::AbstractString)
  # somehow I am not able to make this in a single call...
  tmp = replace(str, 'F'=>'0')
  out = replace(tmp, 'B'=>'1')
  
  # parse the bitstring to int
  return parse(Int, out, base=2)
end
  

# takes a string of Ls and Rs as inputs and returns the corresponding integer
function getcolumn(str::AbstractString)
  # somehow I am not able to make this in a single call...
  tmp = replace(str, 'L'=>'0')
  out = replace(tmp, 'R'=>'1')
  
  # parse the bitstring to int
  return parse(Int, out, base=2)
end
  
getID(row::Int, column::Int) = row*8 + column

maxID = 0

for pass in passes
  id = getID(getrow(pass[1:7]), getcolumn(pass[8:10]))
  if id > maxID
    global maxID = id
  end
end

println("The highest ID is $maxID")

#--- Second Part ---#
println("#--- Second Part ---#")

# an empty seat is a zero, an occupied seat is 1. The running index labels
# the boarding pass ID
seats = zeros(Int,128*8)

# go through the boarding process and for each pass, set the corresponding seat to 1
# the + 1 is necessary because in principle there might be a seat 0
for pass in passes
  global seats[getID(getrow(pass[1:7]), getcolumn(pass[8:10])) + 1] = 1
end

# find where the ids for this flight start
first_id = findfirst(==(1), seats)
last_id  = findlast(==(1), seats)

# according to the description of the problem, there should be only one zero (empty)
# seat left between the first_id and last_id, so we look for it and add the padding
# from the first ids
myid  = findall(==(0),seats[first_id:last_id])[1]
myid += first_id - 1

println("The ID of my seat is $(myid - 1)")





