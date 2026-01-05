import 'dart:io';

void findSum(List<int> a, List<bool> used, int value, int index, int sum) {
  if (index < 0) {
    // in the end of array we will print if we can build our sum in this way ^^
    if (value == 0) {
      for (int i = a.length - 1; i >= 0; i--) {
        if (used[i]) stdout.write('${a[i]}+');  // this flag tells us that we used a[i] to build the sum in this way or no.
      }
      stdout.write('\b=');  // \b deletes the last '+'
      print('$sum');
    }
    return;
  }

  if (value == a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = true;  // we let true in this flag because we use this number to build our sum
    findSum(a, used, 0, index - 1, sum);  // newValue is zero because oldValue-a[index]=0

    //  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    findSum(a, used, value, index - 1, sum);  // newValue=value because we don't use this number(a[index])
  } else if (value < a[index]) {
    // we can't use this number to build our sum because it's bigger than our value
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    findSum(a, used, value, index - 1, sum);
  } else if (value > a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = true;  // we let true in this flag because we use this number to build our sum
    findSum(a, used, value - a[index], index - 1, sum);  // newValue=oldValue-a[index]

    // and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = false;  // we let false in this flag because we use this number to build our sum
    findSum(a, used, value, index - 1, sum);
  }
}

void main() {
  stdout.write('please type the size of array : ');
  String? input = stdin.readLineSync();
  int n = int.parse(input!.trim());  // define variable

  List<int> arr = [];  // define input vector
  List<bool> used = List.filled(n, false);  // define a vector for checking if this number contain our adding ?

  stdout.write('type your array numbers: ');
  input = stdin.readLineSync();
  List<int> numbers = input!.trim().split(RegExp(r'\s+')).map(int.parse).toList();

  arr.addAll(numbers);

  stdout.write('please type your sum that we will try to build it with array numbers : ');
  input = stdin.readLineSync();
  int sum = int.parse(input!.trim());

  arr.sort();  // sort our vector . this line is important if we change it algorithm will not work.
  findSum(arr, used, sum, n - 1, sum);  // call the recursive function to print all the ways we can build sum.
}