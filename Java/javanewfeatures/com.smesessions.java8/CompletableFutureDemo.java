// Importing required Java packages
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

/**
 * Demonstrates the use of CompletableFuture in Java 8
 */
public class CompletableFutureDemo {

    public static void main(String[] args) {
        try {
            // CompletableFuture allows you to write non-blocking code
            // It is a powerful tool for asynchronous programming in Java

            // Simulate fetching user details and orders concurrently
            CompletableFuture<String> userDetailsFuture = fetchUserDetails();
            CompletableFuture<String> userOrdersFuture = fetchUserOrders();

            // Combine results of both futures
            CompletableFuture<String> combinedFuture = userDetailsFuture.thenCombine(userOrdersFuture,
                    (userDetails, userOrders) -> {
                        // Extract user ID from user details
                        String userId = userDetails.split(":")[2].split(",")[0].trim();
                        // Filter orders by user ID
                        String filteredOrders = userOrders.lines()
                                .filter(order -> order.contains("\"userId\": " + userId))
                                .reduce("", (acc, order) -> acc + order + "\n");
                        return userDetails + "\nFiltered Orders:\n" + filteredOrders;
                    });

            // Print the combined result
            System.out.println("Result:\n" + combinedFuture.get());
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
        }
    }

    /**
     * Simulates an asynchronous API call to fetch user details
     */
    private static CompletableFuture<String> fetchUserDetails() {
        return CompletableFuture.supplyAsync(() -> {
            // Simulating delay
            sleep(1000);
            return "User Details: {id: 1, name: 'John Doe'}";
        });
    }
           
    /**
     * Simulates an asynchronous API call to fetch user orders
     */
    private static CompletableFuture<String> fetchUserOrders() {
        return CompletableFuture.supplyAsync(() -> {
            // Simulating delay
            sleep(1500);
            return """
                User Orders: [
                    {"id": 101, "item": "Laptop", "userId": 1},
                    {"id": 102, "item": "Phone", "userId": 1},
                    {"id": 103, "item": "Tablet", "userId": 2},
                    {"id": 104, "item": "Monitor", "userId": 3}
                ]""";
        });
    }

    /**
     * Utility method to simulate delay
     */
    private static void sleep(int millis) {
        try {
            Thread.sleep(millis);
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
        }
    }
}
