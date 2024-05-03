import math

def main():
    choice = 0
    while choice != 7:
        print("1. Add")
        print("2. Subtract")
        print("3. Divide")
        print("4. Multiply")
        print("5. Sin")
        print("6. Cosine")
        print("7. Exit")
        print("Enter your choice:")

        try:
            choice = int(input())
            if choice < 1 or choice > 7:
                print("Invalid choice")
                continue
            if choice == 7:
                print("Exiting...")
                break
            print("Enter first number:")
            num1 = int(input())
            print("Enter second number:")
            num2 = int(input())
            if choice == 1:
                print("Result: " + str(num1 + num2))
            elif choice == 2:
                print("Result: " + str(num1 - num2))
            elif choice == 3:
                print("Result: " + str(num1 / num2))
            elif choice == 4:
                print("Result: " + str(num1 * num2))
            elif choice == 5:
                print("Result: " + str(math.sin(num1)))
            elif choice == 6:
                print("Result: " + str(math.cos(num1)))
            else:
                print("Invalid choice")
        except Exception as e:
            print("Invalid input")

if __name__ == "__main__":
    main()