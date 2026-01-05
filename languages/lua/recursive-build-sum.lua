function find_sum(a, used, value, index, sum)
  if index < 0 then
    -- in the end of array we will print if we can build our sum in this way ^^
    if value == 0 then
      for i = #a, 1, -1 do
        if used[i] then  -- this flag tells us that we used a[i] to build the sum in this way or no.
          io.write(a[i] .. "+")
        end
      end
      io.write("\b=")
      print(sum)
    end
    return
  end

  if value == a[index + 1] then
    -- in two below lines we use current number to build our sum
    used[index + 1] = true  -- we let true in this flag because we use this number to build our sum
    find_sum(a, used, 0, index - 1, sum)  -- newValue is zero because oldValue-a[index]=0

    --  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index + 1] = false  -- we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum)  -- newValue=value because we don't use this number(a[index])
  elseif value < a[index + 1] then
    -- we can't use this number to build our sum because it's bigger than our value
    used[index + 1] = false  -- we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum)
  elseif value > a[index + 1] then
    -- in two below lines we use current number to build our sum
    used[index + 1] = true  -- we let true in this flag because we use this number to build our sum
    find_sum(a, used, value - a[index + 1], index - 1, sum)  -- newValue=oldValue-a[index]

    -- and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index + 1] = false  -- we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum)
  end
end

io.write("please type the size of array : ")
local n = tonumber(io.read())

local arr = {}  -- define input vector
local used = {}  -- define a vector for checking if this number contain our adding ?

io.write("type your array numbers: ")
local numbers = {}
for num in io.read():gmatch("%S+") do
  table.insert(numbers, tonumber(num))
end

for i = 1, #numbers do
  arr[i] = numbers[i]
  used[i] = false
end

io.write("please type your sum that we will try to build it with array numbers : ")
local sum = tonumber(io.read())

table.sort(arr)  -- sort our vector . this line is important if we change it algorithm will not work.
find_sum(arr, used, sum, n - 1, sum)  -- call the recursive function to print all the ways we can build sum.