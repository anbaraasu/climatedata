import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;

public class ReduceDemo {
    public static void main(String[] args) {
        //Demo for reduce function in Java Streams
        // Using reduce to sum up a list of integers
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        // Using reduce to sum up the numbers
        // 1,2 = 3 
        // 3,3 = 6
        // 6,4 = 10
        // 10,5 = 15
        // The first argument is the identity value (0 in this case)
        int sum = numbers.stream()
                .reduce(0, (a, b) -> a + b);

        System.out.println("Reduce w.r.t Interge: Sum: " + sum); // Output: 15

        List<String> words = Arrays.asList("Hello", "World", "Java", "Streams");
        // Using reduce to concatenate the words
        // 1st iteration: "Hello" + "World" = "HelloWorld"
        // 2nd iteration: "HelloWorld" + "Java" = "HelloWorldJava"
        // 3rd iteration: "HelloWorldJava" + "Streams" = "HelloWorldJavaStreams"
        String concatenated = words.stream()
                .reduce("", (a, b) -> a  + b + ",");
        System.out.println("Reduce w.r.t String: Concatenated: " + concatenated); // Output: HelloWorldJavaStreams
        // Using reduce to find the longest word
        String longestWord = words.stream()
                .reduce("", (a, b) -> a.length() > b.length() ? a : b);
        System.out.println("Reduce w.r.t String: Longest word: " + longestWord); // Output: HelloWorldJavaStreams
    }
}
