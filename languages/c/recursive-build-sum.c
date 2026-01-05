#include <stdio.h>
#include <stdlib.h>

void find_sum(int *a, int *used, int value, int index, int sum, int n) {
  if (index < 0) {
    // in the end of array we will print if we can build our sum in this way ^^
    if (value == 0) {
      for (int i = n - 1; i >= 0; i--) {
        if (used[i]) printf("%d+", a[i]);  // this flag tells us that we used a[i] to build the sum in this way or no.
      }
      printf("\b=");
      printf("%d\n", sum);
    }
    return;
  }

  if (value == a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = 1;  // we let true in this flag because we use this number to build our sum
    find_sum(a, used, 0, index - 1, sum, n);  // newValue is zero because oldValue-a[index]=0

    //  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = 0;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum, n);  // newValue=value because we don't use this number(a[index])
  } else if (value < a[index]) {
    // we can't use this number to build our sum because it's bigger than our value
    used[index] = 0;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum, n);
  } else if (value > a[index]) {
    // in two below lines we use current number to build our sum
    used[index] = 1;  // we let true in this flag because we use this number to build our sum
    find_sum(a, used, value - a[index], index - 1, sum, n);  // newValue=oldValue-a[index]

    // and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index] = 0;  // we let false in this flag because we use this number to build our sum
    find_sum(a, used, value, index - 1, sum, n);
  }
}

int compare(const void *a, const void *b) {
  return (*(int *)a - *(int *)b);
}

int main() {
  int n;

  printf("please type the size of array : ");
  scanf("%d", &n);  // define variable

  int *arr = malloc(n * sizeof(int));  // define input vector
  int *used = calloc(n, sizeof(int));  // define a vector for checking if this number contain our adding ?

  printf("type your array numbers: ");
  for (int i = 0; i < n; i++) {
    scanf("%d", &arr[i]);
  }

  int sum;
  // get the sum . we will check if we can build this number with our given numbers 
  printf("please type your sum that we will try to build it with array numbers : ");
  scanf("%d", &sum);

  qsort(arr, n, sizeof(int), compare);  // sort our vector . this line is important if we change it algorithm will not work.
  find_sum(arr, used, sum, n - 1, sum, n);  // call the recursive function to print all the ways we can build sum.

  free(arr);
  free(used);
  return 0;
}
