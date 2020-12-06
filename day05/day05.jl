
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

