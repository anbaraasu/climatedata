package com.smesessions.java11;

/**
 * Java 11 Important Features
 */

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.function.BiFunction;
import java.nio.file.Files;

public class Java11FeaturesDemo {

	public static void main(String[] args) {
		// Demonstrating Java 11 new features

		// 1. New String methods
		// isBlank, strip, and repeat methods
		String multilineString = "  Java 11  ";
		System.out.println("Is blank: " + multilineString.isBlank()); // Check if blank
		System.out.println("Stripped: '" + multilineString.strip() + "'"); // Strip leading and trailing spaces
		System.out.println("Repeat: " + "Java ".repeat(3)); // Repeat string

		// 2. Using var in lambda expressions
		// Using BiFunction functional interface for the lambda expression
		BiFunction<Integer, Integer, Integer> sum = (var a, var b) -> a + b;
		System.out.println("Sum using var in lambda: " + sum.apply(5, 10));

		// 3. Files utility methods
		try {
			var tempFile = Files.createTempFile("demo", ".txt");
			System.out.println("Temporary file created: " + tempFile);
		} catch (java.io.IOException e) {
			e.printStackTrace();
		}

		// 4. Optional enhancements
		java.util.Optional<String> optional = Optional.of("Java 11");
		System.out.println("Optional is empty: " + optional.isEmpty());
	}
}
