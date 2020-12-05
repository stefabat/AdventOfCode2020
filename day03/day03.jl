
# The description for this problem is too long to write it here
# go and check https://adventofcode.com/2020/day/3

# The idea is start at the top left corner and just add right and
# down in a loop, check if the corresponding entry is a tree or not,
# and keep a counter. Because there are "periodic boundary conditions"
# along the second dimension, we just need to use the modulo operator

using DelimitedFiles

slope = vec(readdlm("input.txt",' ',String))

N = length(slope)
M = length(slope[1])

# set the movements
down  = 1
right = 3

# indices to access the map
i = 1
j = 0 # starting at zero because we use the modulo

# counter
trees = 0

while i < N
  global i += down
  global j  = (j + right)%M

  if slope[i][j+1] == '#'
    global trees += 1
  end
end

println("Total number of trees encountered: $trees")

#--- Part two ---#

println("#--- Part two ---#")

# set up an array containing the movements as namedtuples
movements = [(down = 1, right = 1),
             (down = 1, right = 3),
             (down = 1, right = 5),
             (down = 1, right = 7),
             (down = 2, right = 1)]

# counter of trees for each movement combination
trees = zeros(Int, length(movements))

for (k,movement) in enumerate(movements)
  global down  = movement.down
  global right = movement.right

  # indices to access the map
  global i = 1
  global j = 0 # starting at zero because we use the modulo

  while i < N
    i += down
    j  = (j + right)%M

    if slope[i][j+1] == '#'
      global trees[k] += 1
    end
  end

  println("Total number of trees encountered with down $down, right $right: $(trees[k])")
end

println("Product of all trees encountered: $(prod(trees))")





