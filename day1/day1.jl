
# Puzzle description: given an array of expenses (nonnegative integers),
# find the two entries that sum up to 2020 and return their product.
# I am assuming that there is only one such pair, or if not, I return
# the first one I found.

using DelimitedFiles

# read input
expenses = vec(Int.(readdlm("input.txt")))

# sort in ascending order
sort!(expenses, alg=QuickSort, lt=isless)

# initialize two indices that will traverse the array
i₀ = 1
i₁ = length(expenses)

# traverse the array and sum elements from both ends inwards
while i₀ ≤ i₁
  sum = expenses[i₀] + expenses[i₁]
  
  # if we are below 2020, we need to increase the lower expense
  if sum < 2020
    global i₀ += 1
  # if we are above 2020, we need to decrease the higher expense
  elseif sum > 2020
    global i₁ -= 1
  # bingo!
  else
    global answer = expenses[i₀] * expenses[i₁]
    break
  end
end

if i₀ ≤ i₁
  println("The answer is: $(expenses[i₀]) * $(expenses[i₁]) = $answer")
else
  println("No two expenses added up to 2020")
end

println("#--- Second Part ---#")
#--- Second Part ---#
#
# Do the same, now with three numbers

# traverse the array and sum elements from both ends inwards
# and traverse between the two exernal indices in ascending order
for i₀ = 1:length(expenses)
  #println("i₀ = $i₀ , i₁ = $i₁ , i₂ = $i₂")
  #println("partial_sum = $partial_sum")
  global i₁ = i₀+1
  global i₂ = length(expenses)
  
  # we need to traverse with the middle index
  while i₁ < i₂
      #println("i₀ = $i₀ , i₁ = $i₁ , i₂ = $i₂")
      a = expenses[i₀] 
      b = expenses[i₁] 
      c = expenses[i₂] 
      sum = a + b + c
      #println("total_sum = $sum")
      
      # we can increase the inner index if we are still below 2020
      if sum < 2020

        global i₁ += 1
      
      elseif sum > 2020
        
        global i₂ -= 1
      
      elseif sum == 2020
        
        println("The answer is: $a * $b * $c = $(a*b*c)")
        exit()

      end
    end
end

