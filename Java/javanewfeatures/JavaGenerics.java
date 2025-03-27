/**
 * Java Generics Example:
 * 
 * Generics allow you to create classes, interfaces, and methods that take a type parameter.
 * This enables types (classes and interfaces) to be parameters when defining classes, interfaces, and methods.
 * 
 * Generics provide a way to ensure type safety at compile time, reducing the risk of ClassCastException at runtime.
 * 
 * Generics was introducted in Java 5, later versions have added more features and enhancements.
 * In Java 7, the diamond operator <> was introduced to simplify the syntax of generics.
 * In Java 8, generics were enhanced with the introduction of type inference and lambda expressions.
 * 
 */
import java.util.ArrayList;
import java.util.List;

public class JavaGenerics {
    public static void main(String[] args) {
        List<String> lst = new ArrayList<>();
        lst.add("Apple");
        String a = lst.get(0); // No need for casting
        System.out.println(a);
    }
}

