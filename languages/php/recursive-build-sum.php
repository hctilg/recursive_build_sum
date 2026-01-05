<?php

function findSum($a, &$used, $value, $index, $sum) {
  if ($index < 0) {
    // At the end of the array, we print if we can build our sum in this way ^^
    if ($value == 0) {
      foreach (array_reverse(range(0, count($a) - 1)) as $i) {
        if ($used[$i]) { // This flag tells us if we used $a[$i] to build the sum in this way or not.
          echo $a[$i] . "+";
        }
      }
      echo "=$sum" . PHP_EOL;
    }
    return;
  }

  if ($value == $a[$index]) {
    // Using the current number to build our sum
    $used[$index] = true;
    findSum($a, $used, 0, $index - 1, $sum); // $newValue is zero because $oldValue - $a[$index] = 0

    // Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    $used[$index] = false;
    findSum($a, $used, $value, $index - 1, $sum);
  } elseif ($value < $a[$index]) {
    // We can't use this number to build our sum because it's larger than our value
    $used[$index] = false;
    findSum($a, $used, $value, $index - 1, $sum);
  } elseif ($value > $a[$index]) {
    // Using the current number to build our sum
    $used[$index] = true;
    findSum($a, $used, $value - $a[$index], $index - 1, $sum); // $newValue = $oldValue - $a[index]

    // Not using the current number to build our sum. If these two lines are deleted, we will not have all the ways.
    $used[$index] = false;
    findSum($a, $used, $value, $index - 1, $sum);
  }
}

echo "please type the size of array : ";
$n = (int)readline();

echo "type your array numbers: ";
$numbers = preg_split('/\s+/', readline(), -1, PREG_SPLIT_NO_EMPTY);

$used = array_fill(0, $n, false);

echo "please type your sum that we will try to build it with array numbers : ";
$sum = (int)readline();

sort($numbers);
findSum($numbers, $used, $sum, $n - 1, $sum);