//Convert CarApp.java file to kotlin

import java.util.*

// Console Kotlin application to store
// Car details like name, model, company, price, color, etc.
// have menu to add, delete, update, search, list car details.

data class Car(
    var name: String,
    var model: String,
    var company: String,
    var price: Double,
    var color: String
)

fun main() {
    val scanner = Scanner(System.`in`)
    val cars = mutableListOf<Car>()
    var choice: Int
    do {
        println("1. Add Car")
        println("2. Delete Car")
        println("3. Update Car")
        println("4. Search Car")
        println("5. List Car")
        println("6. Exit")
        println("Enter your choice: ")
        choice = scanner.nextInt()
        when (choice) {
            1 -> {
                println("Enter Car Name: ")
                val name = scanner.next()
                println("Enter Car Model: ")
                val model = scanner.next()
                println("Enter Car Company: ")
                val company = scanner.next()
                println("Enter Car Price: ")
                val price = scanner.nextDouble()
                println("Enter Car Color: ")
                val color = scanner.next()
                val car = Car(name, model, company, price, color)
                cars.add(car)
            }
            2 -> {
                println("Enter Car Name: ")
                val deleteName = scanner.next()
                cars.removeIf { it.name == deleteName }
            }
            3 -> {
                println("Enter Car Name: ")
                val updateName = scanner.next()
                for (car in cars) {
                    if (car.name == updateName) {
                        println("Enter Car Model: ")
                        car.model = scanner.next()
                        println("Enter Car Company: ")
                        car.company = scanner.next()
                        println("Enter Car Price: ")
                        car.price = scanner.nextDouble()
                        println("Enter Car Color: ")
                        car.color = scanner.next()
                        break
                    }
                }
            }
            4 -> {
                println("Enter Car Name: ")
                val searchName = scanner.next()
                cars.find { it.name == searchName }?.let { println(it) }
            }
            5 -> cars.forEach { println(it) }
            6 -> println("Exiting...")
            else -> println("Invalid choice")
        }
    } while (choice != 6)
}