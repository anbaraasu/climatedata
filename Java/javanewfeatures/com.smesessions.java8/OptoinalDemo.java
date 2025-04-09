import java.util.Optional;
/**
 * This is a demo class to show how to use Optional in Java 8.
 * Optional is a container object which may or may not contain a non-null value.
 */
public class OptoinalDemo {
    public static void main(String[] args) {
        // Creating an Optional object that contains a non-null value
        Optional<String> optionalValue = Optional.of("Hello, Java 8!");

        // Using ifPresent to execute a block of code if the value is present
        optionalValue.ifPresent(value -> System.out.println("Value is present: " + value));

        // Using orElse to provide a default value if the Optional is empty
        String defaultValue = optionalValue.orElse("Default Value");
        System.out.println("Value or Default: " + defaultValue);

        // Using map to transform the value inside the Optional
        Optional<String> transformedValue = optionalValue.map(String::toUpperCase);
        transformedValue.ifPresent(value -> System.out.println("Transformed Value: " + value));
    }
}
