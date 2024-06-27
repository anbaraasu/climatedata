import java.util.Scanner

fun main() {
    val scanner = Scanner(System.`in`)
    val products = mutableListOf<Product>()

    while (true) {
        /**
         * Prints the message "1. List Products" to the console.
         */
        println("1. List Products")
        println("2. Add Product")
        println("3. Exit")
        print("Enter choice: ")
        try {
            val choice = scanner.nextInt()
            scanner.nextLine() // Consume newline
            when (choice) {
                1 -> listProducts(products)
                2 -> addProduct(scanner, products)
                3 -> {
                    println("Exiting...")
                    return
                }
                else -> println("Invalid choice, try again.")
            }
        } catch (e: InputMismatchException) {
            println("Invalid input, please enter a number.")
            scanner.nextLine() // Consume the invalid input
        }
    }
}

fun listProducts(products: MutableList<Product>) {
    if (products.isEmpty()) {
        println("No products available.")
    } else {
        println("ID\tName\tDescription\tQuantity\tUnit Price")
        for (product in products) {
            println(product)
        }
    }
}

fun addProduct(scanner: Scanner, products: MutableList<Product>) {
    print("Enter ID: ")
    val id = scanner.nextInt()
    scanner.nextLine() // Consume newline
    print("Enter Name: ")
    val name = scanner.nextLine()
    print("Enter Description: ")
    val description = scanner.nextLine()
    print("Enter Quantity: ")
    val quantity = try {
        scanner.nextInt()
    } catch (e: InputMismatchException) {
        println("Invalid input for Quantity, please enter a valid integer.")
        scanner.nextLine() // Consume the invalid input
        return
    }

    print("Enter Unit Price: ")
    val unitPrice = try {
        scanner.nextDouble()
    } catch (e: InputMismatchException) {
        println("Invalid input for Unit Price, please enter a valid decimal number.")
        scanner.nextLine() // Consume the invalid input
        return
    }
    scanner.nextLine() // Consume newline
    products.add(Product(id, name, description, quantity, unitPrice))
    println("Product added successfully.")
}

data class Product(
    val id: Int,
    val name: String,
    val description: String,
    val quantity: Int,
    val unitPrice: Double
)