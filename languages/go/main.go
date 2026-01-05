package main

import (
	"bufio"
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func findSum(a []int, used []bool, value, index, sum int) {
	if index < 0 {
		// in the end of array we will print if we can build our sum in this way ^^
		if value == 0 {
			for i := len(a) - 1; i >= 0; i-- {
				if used[i] { // this flag tells us that we used a[i] to build the sum in this way or no.
					fmt.Printf("%d+", a[i])
				}
			}
			fmt.Printf("\b=%d\n", sum)
		}
		return
	}

	if value == a[index] {
		// in two below lines we use current number to build our sum
		used[index] = true // we let true in this flag because we use this number to build our sum
		findSum(a, used, 0, index-1, sum) // newValue is zero because oldValue-a[index]=0

		// and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
		used[index] = false // we let false in this flag because we use this number to build our sum
		findSum(a, used, value, index-1, sum) // newValue=value because we don't use this number(a[index])
	} else if value < a[index] {
		// we can't use this number to build our sum because it's bigger than our value
		used[index] = false // we let false in this flag because we use this number to build our sum
		findSum(a, used, value, index-1, sum)
	} else if value > a[index] {
		// in two below lines we use current number to build our sum
		used[index] = true // we let true in this flag because we use this number to build our sum
		findSum(a, used, value-a[index], index-1, sum) // newValue=oldValue-a[index]

		// and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
		used[index] = false // we let false in this flag because we use this number to build our sum
		findSum(a, used, value, index-1, sum)
	}
}

func main() {
	reader := bufio.NewReader(os.Stdin)

	fmt.Print("please type the size of array : ")
	nStr, _ := reader.ReadString('\n')
	n, _ := strconv.Atoi(strings.TrimSpace(nStr))

	fmt.Print("type your array numbers: ")
	numbersStr, _ := reader.ReadString('\n')
	numbersParts := strings.Fields(numbersStr)

	arr := make([]int, 0, n)
	for _, part := range numbersParts {
		num, _ := strconv.Atoi(part)
		arr = append(arr, num)
	}

	used := make([]bool, n)

	fmt.Print("please type your sum that we will try to build it with array numbers : ")
	sumStr, _ := reader.ReadString('\n')
	sum, _ := strconv.Atoi(strings.TrimSpace(sumStr))

	sort.Ints(arr) // sort our slice . this line is important if we change it algorithm will not work.
	findSum(arr, used, sum, n-1, sum) // call the recursive function to print all the ways we can build sum.
}
