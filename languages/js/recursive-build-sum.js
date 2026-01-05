function find_sum(a, used, value, index, sum) {
  if (index < 0) {
    // in the end of array we will print if we can build our sum in this way ^^
    if (value === 0) {
      let result = '';
      for (let i = a.length - 1; i >= 0; i--) {
        if (used[i]) result += a[i] + '+';  // this flag tells us that we used a[i] to build the sum in this way or no.
      }
      result = result.slice(0, -1); // remove last '+'
      console.log(result + '=' + sum);
    }
    return;
  }

  if (value === a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = true;  // we let true in this flag because we use this number to build our sum
    find_sum(a, used, 0, index - 1, sum);  // newValue is zero because oldValue-a[index]=0

    //  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum);  // newValue=value because we don't use this number(a[index])
  } else if (value < a[index]) {
    // we can't use this number to build our sum because it's bigger than our value
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum);
  } else if (value > a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = true;  // we let true in this flag because we use this number to build our sum
    find_sum(a, used, value - a[index], index - 1, sum);  // newValue=oldValue-a[index]

    // and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum);
  }
}

const readline = require('readline').createInterface({
  input: process.stdin,
  output: process.stdout
});

const ask = question => new Promise(resolve => readline.question(question, answer => resolve(answer)));

(async () => {
  let input;

  input = await ask("please type the size of array : ");
  const n = parseInt(input.trim(), 10);  // define variable

  input = await ask("type your array numbers: ");
  const numbers = input.trim().split(/\s+/).map(Number);
  let arr = [...numbers];  // define input vector
  let used = new Array(n).fill(false);  // define a vector for checking if this number contain our adding ?

  input = await ask("please type your sum that we will try to build it with array numbers : ");
  const sum = parseInt(input.trim(), 10);

  arr.sort((a, b) => a - b);  // sort our vector . this line is important if we change it algorithm will not work.
  find_sum(arr, used, sum, n - 1, sum);  // call the recursive function to print all the ways we can build sum.

  readline.close();
})();