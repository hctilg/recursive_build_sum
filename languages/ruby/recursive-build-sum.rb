#!/usr/bin/env ruby
 
def find_sum(a, used, value, index, sum)
  if index < 0
    # in the end of the array, we print if we can build our sum in this way ^^
    if value == 0
      (a.length - 1).downto(0) do |i|
        if used[i]
          print a[i].to_s + "+"
        end
      end
      puts "=#{sum}"
    end
    return
  end

  if value == a[index]
    # Using the current number to build our sum
    used[index] = true
    find_sum(a, used, 0, index - 1, sum)  # newValue is zero because oldValue - a[index] = 0

    # Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    used[index] = false
    find_sum(a, used, value, index - 1, sum)
  elsif value < a[index]
    # We can't use this number to build our sum because it's larger than our value
    used[index] = false
    find_sum(a, used, value, index - 1, sum)
  elsif value > a[index]
    # Using the current number to build our sum
    used[index] = true
    find_sum(a, used, value - a[index], index - 1, sum)  # newValue = oldValue - a[index]

    # Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    used[index] = false
    find_sum(a, used, value, index - 1, sum)
  end
end

print "please type the size of array : "
n = gets.chomp.to_i

print "type your array numbers: "
numbers = gets.chomp.split(' ').map(&:to_i)

used = [false] * n

print "please type your sum that we will try to build it with array numbers : "
sum = gets.chomp.to_i

numbers.sort!
find_sum(numbers, used, sum, n - 1, sum)