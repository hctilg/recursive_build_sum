#!/usr/bin/env python
 
def find_sum(a, used, value, index, sum):
  if index < 0:
    # in the end of the array, we print if we can build our sum in this way ^^
    if value == 0:
      for i in reversed(range(len(a))):
        if used[i]:
          print(str(a[i]) + "+", end="")
      print("=" + str(sum))
    return

  if value == a[index]:
    # Using the current number to build our sum
    used[index] = True
    find_sum(a, used, 0, index - 1, sum)  # newValue is zero because oldValue - a[index] = 0

    # Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    used[index] = False
    find_sum(a, used, value, index - 1, sum)
  elif value < a[index]:
    # We can't use this number to build our sum because it's larger than our value
    used[index] = False
    find_sum(a, used, value, index - 1, sum)
  elif value > a[index]:
    # Using the current number to build our sum
    used[index] = True
    find_sum(a, used, value - a[index], index - 1, sum)  # newValue = oldValue - a[index]

    # Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    used[index] = False
    find_sum(a, used, value, index - 1, sum)

n = int(input("please type the size of array : "))

numbers = [int(x) for x in input("type your array numbers: ").split()]

used = [False] * n

sum_value = int(input("please type your sum that we will try to build it with array numbers : "))

numbers.sort()
find_sum(numbers, used, sum_value, n - 1, sum_value)