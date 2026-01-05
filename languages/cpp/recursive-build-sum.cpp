#include <iostream>
#include <algorithm>
#include <vector>

using namespace std;

void findSum(vector <int>a,vector <bool> used,int value,int index,int sum){
  if (index<0){
    //in the end of array we will print if we can build our sum in this way ^^
    if (value==0){
      for (int i=(a.size())-1;i>=0;i--){
        if(used[i])//this flag tells us that we used a[i] to build the sum in this way or no.
          cout<<a[i]<<"+";
        }
      cout<<'\b'<<"="<<sum<<endl;
      }
    return ;
    }
  if (value==a[index]){
    //in two below lines we use current number to build our sum
    used[index]=true;//we let true in this flag because we use this number to build our sum
    findSum(a,used,0,index-1,sum);//newValue is zero because oldValue-a[index]=0

    //and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index]=false;//we let false in this flag because we use this number to build our sum
    findSum(a,used,value,index-1,sum);//newValue=value because we don't use this number(a[index])
    }
  else if(value<a[index]){
    //we can't use this number to build our sum because it's bigger than our value
    used[index]=false;//we let false in this flag because we use this number to build our sum
    findSum(a,used,value,index-1,sum);
    }
  else if(value>a[index]){
    //in two below lines we use current number to build our sum
    used[index]=true;//we let true in this flag because we use this number to build our sum
    findSum(a,used,value-a[index],index-1,sum);//newValue=oldValue-a[index]

    //and in two below lines we will not use current number to build our sum . if we delete these two below lines we will not have all the ways.
    used[index]=false;//we let false in this flag because we use this number to build our sum
    findSum(a,used,value,index-1,sum);  
    }
  return ;
}

int main(){

  int n,sum;//define variables
  cout<<"please type the size of array : ";
  cin>>n;//get the size of input array
  vector<int> arr;//define input vector
  vector<bool> used;//define a vector for checking if this number contain our adding ?

  cout<<"type your array numbers: ";
  for (int i=0;i<n;i++){
    int temp;
    cin>>temp;
    arr.push_back(temp);
    used.push_back(false);
  }

  cout<<"please type  your sum that we will try to build it with array numbers : ";
  cin>>sum;//get the sum . we will check if we can build this number with our given numbers 
  sort(arr.begin(),arr.end());//sort our vector . this line is important if we change it algorithm will not work

  findSum(arr,used,sum,n-1,sum);//call the recursive function to print all the ways we can build sum.

  return 0;
}