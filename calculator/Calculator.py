# Python console program with menu options for Add, Subtract, Multiply, Divide and Exit: with exception handling for divide by zero, input mismatch and invalid choice
while True:
    print("Calculator Menu")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    print("5. Exit")
    choice = input("Enter your choice: ")
    if choice == '5':
        print("Exiting calculator...")
        break
    # Only if valid choice is entered, ask for numbers
    try:
        num1 = float(input("Enter first number: "))
        num2 = float(input("Enter second number: "))
        if choice == '1':
            print("Result: ", num1 + num2)
        elif choice == '2':
            print("Result: ", num1 - num2)
        elif choice == '3':
            print("Result: ", num1 * num2)
        elif choice == '4':
            if num2 != 0:
                print("Result: ", num1 / num2)
            else:
                print("Error: Division by zero is not allowed.")
        else:
            print("Invalid choice.")
    except ValueError:
        print("Error: Invalid input. Please enter a number.")