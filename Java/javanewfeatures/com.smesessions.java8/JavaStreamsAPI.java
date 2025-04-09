import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
/**
 * Java Streams API: Streams are a new abstraction introduced in Java 8 that allow for functional-style operations 
 * on collections of objects.
 * Streams has 3 main components:
 * 1. Source: A stream can be created from a variety of data sources, including collections, arrays, or I/O channels.
 * 2. Intermediate operations: These are operations that transform a stream into another stream, such as filter, map, and sorted.
 * 3. Terminal operations: These are operations that produce a result or a side-effect, such as forEach, collect, and reduce.
 * 
 * 
 */


public class JavaStreamsAPI {
    public static void main(String[] args) {
        Integer[] studentScore = { 10, 20, 30, 40, 50, 60, 70, 80, 90 };
        // Create a stream from the array of student scores
        // and filter the scores greater than 50
        Integer[] filteredScores = java.util.Arrays.stream(studentScore)
                .filter(score -> score > 50)
                .toArray(Integer[]::new);
        
        // Print the filtered scores
        System.out.println("Filtered Scores from Array Object: ");
        for (Integer score : filteredScores) {
            System.out.print(score + " ");
        }
        System.out.println();

        List<String> names = new ArrayList<>();
        names.add("John");
        names.add("Jane");
        names.add("Jack");
        names.add("Jill");
        names.add("Joe");
        names.add("Jim");
        names.add("Jerry");
        names.add("Anbu");

        // Filter starts with J and have only 3 letters
        System.out.println("Filtered Names from List Object: ");
        names.stream()
                .filter(name -> name.startsWith("J") && name.length() == 3)
                .collect(Collectors.toList()).forEach(System.out::println);
    }
}
