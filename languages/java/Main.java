import java.util.*;  // for Scanner and Arrays

public class Main {
  static void find_sum(int[] a, boolean[] used, int value, int index, int sum) {
    if (index < 0) {
      // in the end of array we will print if we can build our sum in this way ^^
      if (value == 0) {
        for (int i = a.length - 1; i >= 0; i--) {
          if (used[i]) System.out.print(a[i] + "+");  // this flag tells us that we used a[i] to build the sum in this way or no.
        }
        System.out.print("\b=");  // remove last '+' and add '='
        System.out.println(sum);
      }
      return;
    }

    if (value == a[index]) {
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

  public static void main(String[] args) {
    Scanner sc = new Scanner(System.in);

    System.out.print("please type the size of array : ");
    int n = sc.nextInt();  // define variable

    int[] arr = new int[n];  // define input array
    boolean[] used = new boolean[n];  // define a array for checking if this number contain our adding ?

    System.out.print("type your array numbers: ");
    for (int i = 0; i < n; i++) {
      arr[i] = sc.nextInt();
      used[i] = false;
    }

    System.out.print("please type your sum that we will try to build it with array numbers : ");
    int sum = sc.nextInt();  // get the sum . we will check if we can build this number with our given numbers 

    Arrays.sort(arr);  // sort our array . this line is important if we change it algorithm will not work.
    find_sum(arr, used, sum, n - 1, sum);  // call the recursive function to print all the ways we can build sum.
  }
}