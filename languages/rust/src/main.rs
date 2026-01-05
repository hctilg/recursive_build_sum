use std::io::{self, Write};

fn find_sum(a: &[i32], used: &mut Vec<bool>, value: i32, index: i32, sum: i32) {
    if index < 0 {
        // in the end of array we will print if we can build our sum in this way ^^
        if value == 0 {
            for i in (0..a.len()).rev() {
                if used[i] {  // this flag tells us that we used a[i] to build the sum in this way or no.
                    print!("{}+", a[i]);
                }
            }
            print!("{}", "\u{0008}=");
            println!("{}", sum);
        }
        return;
    }

    if value == a[index as usize] {
        // in two below lines we use current number to build our sum
        used[index as usize] = true;  // we let true in this flag because we use this number to build our sum
        find_sum(a, used, 0, index - 1, sum);  // newValue is zero because oldValue-a[index]=0

        //  and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
        used[index as usize] = false;  // we let false in this flag because we use this number to build our sum
        find_sum(a, used, value, index - 1, sum);  // newValue=value because we don't use this number(a[index])
    } else if value < a[index as usize] {
        // we can't use this number to build our sum because it's bigger than our value
        used[index as usize] = false;  // we let false in this flag because we use this number to build our sum
        find_sum(a, used, value, index - 1, sum);
    } else if value > a[index as usize] {
        // in two below lines we use current number to build our sum
        used[index as usize] = true;  // we let true in this flag because we use this number to build our sum
        find_sum(a, used, value - a[index as usize], index - 1, sum);  // newValue=oldValue-a[index]

        // and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
        used[index as usize] = false;  // we let false in this flag because we use this number to build our sum
        find_sum(a, used, value, index - 1, sum);
    }
}

fn main() {
    let mut input = String::new();

    print!("please type the size of array : ");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut input).unwrap();
    let n: usize = input.trim().parse().unwrap();  // define variable

    let mut arr: Vec<i32> = Vec::new();  // define input vector
    let mut used: Vec<bool> = Vec::new();  // define a vector for checking if this number contain our adding ?

    input.clear();
    print!("type your array numbers: ");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut input).unwrap();
    let numbers: Vec<i32> = input
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();
    
    arr.extend(numbers.iter());
    used.resize(n, false);

    input.clear();  // get the sum . we will check if we can build this number with our given numbers 
    print!("please type your sum that we will try to build it with array numbers : ");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut input).unwrap();
    let sum: i32 = input.trim().parse().unwrap();

    arr.sort();  // sort our vector . this line is important if we change it algorithm will not work.
    find_sum(&arr, &mut used, sum, n as i32 - 1, sum);  // call the recursive function to print all the ways we can build sum.
}
