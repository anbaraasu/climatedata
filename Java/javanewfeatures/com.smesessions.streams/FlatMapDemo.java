import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class FlatMapDemo {
    public static void main(String[] args) {
        List<String> list1 = Arrays.asList("A", "B", "C");
        List<String> list2 = Arrays.asList("D", "E", "F");
        List<String> list3 = Arrays.asList("G", "H", "I");

        List<List<String>> listOfLists = Arrays.asList(list1, list2, list3);
        System.out.println("Before flattening: ");
        System.out.println(listOfLists); // Output: [[A, B, C], [D, E, F], [G, H, I]]
        // Using flatMap to flatten the lists
        List<String> flattenedList = listOfLists.stream()
                .flatMap(List::stream)
                .collect(Collectors.toList());
                System.out.println("After flatmap: ");
        System.out.println(flattenedList); // Output: [A, B, C, D, E, F, G, H, I]
    }

}