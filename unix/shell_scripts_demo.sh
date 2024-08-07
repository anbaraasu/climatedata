# Exercise 1 - print hello world 
#!/bin/bash
echo "Hello World"


# Exercise 2 - print the current date in the format "Today is: <date>"
#!/bin/bash
echo "Today is: $(date)"

# Exercise 3 - print the current time in the format "Time is: <time>"
#!/bin/bash
echo "Time is: $(date +%T)"

# Exercise 4 - print the current date and time in the format "Current date and time: <date> <time>"
#!/bin/bash
echo "Current date and time: $(date +'%Y-%m-%d %H:%M:%S')"

# Exercise 5 - demo for if statement, ask the user to enter a number and print if it is even or odd
#!/bin/bash
echo "Enter a number: "
read num
if [ $((num % 2)) -eq 0 ]; then
  echo "The number is even"
else
  echo "The number is odd"
fi

# Exercise 6 - demo for if, else if statement, ask the user to enter a number and print if it is positive, negative or zero
#!/bin/bash
echo "Enter a number: "
read num
if [ $num -gt 0 ]; then
  echo "The number is positive"
elif [ $num -lt 0 ]; then
  echo "The number is negative"
else
  echo "The number is zero"
fi

# Exercise 7 - demo for nested if, ask the user to enter a age and gender. If the age is above 58 and gender is female, print a message "You are eligible to maximum TAX deduction", else print "You are not eligible for TAX deduction". If the age is above 60 and gender is male, print a message "You are eligible to maximum TAX deduction", else print "You are not eligible for TAX deduction"
#!/bin/bash
echo "Enter your age: "
read age
echo "Enter your gender[Male,Female]: "
read gender
if [ $age -gt 58 ]; then
  if [ $gender == "Male" ]; then
    echo "You are eligible to maximum TAX deduction"
  else
    echo "You are eligible for normal TAX deduction"
  fi
elif [ $age -gt 60 ]; then
    if [ $gender == "Female"]; then 
        echo "You are eligible to maximum TAX deduction"
    else
    echo "You are not for normal TAX deduction"
    fi
else
    echo "You are not eligible for TAX deduction"
fi

# Exercise 8 - demo for for loop, print prime numbers from 1 to 10, 
#!/bin/bash
for num in {1..10}
do
  flag=0
  for i in $(seq 2 $((num/2)))
  do
    if [ $((num % i)) -eq 0 ]; then
      flag=1
      break
    fi
  done
  if [ $flag -eq 0 ]; then
    echo $num
  fi
done

# Exercise 9 - demo for while loop, print square of each numbers from 1 to 10
#!/bin/bash
num=1
while [ $num -le 10 ]
do
  echo $((num * num))
  num=$((num + 1))
done

# Exercise 10 - demo for until loop, print cube of each numbers from 1 to 10
#!/bin/bash
num=1
until [ $num -gt 10 ]
do
  echo $((num * num * num))
  num=$((num + 1))
done

# Exercise 11 - demo for case statement, ask the user to enter a number and print the corresponding day of the week
#!/bin/bash
echo "Enter a number between 1 and 7: "
read num
case $num in
  1)
    echo "Sunday"
    ;;
  2)
    echo "Monday"
    ;;
  3)
    echo "Tuesday"
    ;;
  4)
    echo "Wednesday"
    ;;
  5)
    echo "Thursday"
    ;;
  6)
    echo "Friday"
    ;;
  7)
    echo "Saturday"
    ;;
  *)
    echo "Invalid number"
    ;;
esac

# Exercise 12 - demo for functions, write a function to check if a number is prime or not
#!/bin/bash
is_prime() {
  num=$1
  flag=0
  for i in $(seq 2 $((num/2)))
  do
    if [ $((num % i)) -eq 0 ]; then
      flag=1
      break
    fi
  done
  if [ $flag -eq 0 ]; then
    echo "$num is prime"
  else
    echo "$num is not prime"
  fi
}
is_prime 7
is_prime 10

