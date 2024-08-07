#!/bin/bash

# Create few Samples files, add menu and Demo w.r.t cat, sort, uniq, grep, cut, sed, awk, tr, wc, diff, patch, nl, head, tail, tee, fmt, pr, iconv, dos2unix, rev, fold, join

# Create sample files
echo -e "apple\nbanana\napple\norange\nbanana" > fruits.txt
echo -e "1 apple\n2 banana\n3 carrot" > list1.txt
echo -e "3 carrot\n4 date\n5 eggplant" > list2.txt
echo "Hello World" > hello.txt

# Display menu for demos
echo "Select a demo:"
echo "1. cat - Display the contents of a file."
echo "2. sort - Sort the lines of a file."
echo "3. uniq - Remove duplicate lines from a sorted file."
echo "4. grep - Search for a pattern in a file."
echo "5. cut - Extract specific columns from a file."
echo "6. sed - Stream editor for filtering and transforming text."
echo "7. awk - Pattern scanning and processing language."
echo "8. tr - Translate or delete characters."
echo "9. wc - Count lines, words, and characters in a file."
echo "10. diff - Compare two files line by line."
echo "11. patch - Apply changes to a file based on a diff file."
echo "12. nl - Number lines of a file."
echo "13. head - Output the first part of a file."
echo "14. tail - Output the last part of a file."
echo "15. tee - Redirect output to multiple files."
echo "16. fmt - Reformat paragraph text."
echo "17. pr - Format files for printing."
echo "18. iconv - Convert text file encoding."
echo "19. dos2unix - Convert DOS/Windows line endings to Unix line endings."
echo "20. rev - Reverse the characters of each line in a file."
echo "21. fold - Wrap each input line to fit in specified width."
echo "22. join - Join lines of two files on a common field."

# Read user input
read -p "Enter the number of the demo you want to run: " choice

# Run the selected demo
case $choice in
	1) echo "cat demo:"
	   cat fruits.txt;;
	2) echo -e "\nsort demo:"
	   sort fruits.txt;;
	3) echo -e "\nuniq demo:"
	   sort fruits.txt | uniq;;
	4) echo -e "\ngrep demo:"
	   grep "apple" fruits.txt;;
	5) echo -e "\ncut demo:"
	   cut -d " " -f 2 list1.txt;;
	6) echo -e "\nsed demo:"
	   sed 's/apple/kiwi/' fruits.txt;;
	7) echo -e "\nawk demo:"
	   awk '{print $2}' list1.txt;;
	8) echo -e "\ntr demo:"
	   echo "hello world" | tr '[:lower:]' '[:upper:]';;
	9) echo -e "\nwc demo:"
	   wc fruits.txt;;
	10) echo -e "\ndiff demo:"
		diff list1.txt list2.txt;;
	11) echo -e "\npatch demo:"
		diff -u list1.txt list2.txt > list.diff
		patch list1.txt < list.diff;;
	12) echo -e "\nnl demo:"
		nl fruits.txt;;
	13) echo -e "\nhead demo:"
		head fruits.txt;;
	14) echo -e "\ntail demo:"
		tail fruits.txt;;
	15) echo -e "\ntee demo:"
		echo "Example text" | tee example.txt;;
	16) echo -e "\nfmt demo:"
		fmt hello.txt;;
	17) echo -e "\npr demo:"
		pr fruits.txt;;
	18) echo -e "\niconv demo:"
		iconv -f UTF-8 -t ASCII hello.txt;;
	19) echo -e "\ndos2unix demo:"
		dos2unix hello.txt;;
	20) echo -e "\nrev demo:"
		rev hello.txt;;
	21) echo -e "\nfold demo:"
		fold -w 10 hello.txt;;
	22) echo -e "\njoin demo:"
		join list1.txt list2.txt;;
	*) echo "Invalid choice";;
esac


# read input as age, print if age is < 13 - kids, age > 12 and < 20 teenagers, age > 19 and < 60 adults, age > 59 senior citizens
echo "Enter your age: "
read age

if [ $age -lt 13 ]; then
	echo "You are a kid."
elif [ $age -ge 13 ] && [ $age -lt 20 ]; then
	echo "You are a teenager."
fi
