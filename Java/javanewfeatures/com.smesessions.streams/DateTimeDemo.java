import java.time.LocalDate;
import java.time.LocalTime;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.ZoneId;

public class DateTimeDemo {
    public static void main(String[] args) {
        // Demo for Date and Time API in Java 8
        // Using LocalDate to get the current date
        LocalDate currentDate = LocalDate.now();
        System.out.println("Current Date: " + currentDate); // Output: Current Date: YYYY-MM-DD

        // Using LocalTime to get the current time
        LocalTime currentTime = LocalTime.now();
        System.out.println("Current Time: " + currentTime); // Output: Current Time: HH:MM:SS

        // Using LocalDateTime to get the current date and time
        LocalDateTime currentDateTime = LocalDateTime.now();
        System.out.println("Current Date and Time: " + currentDateTime); // Output: Current Date and Time:
                                                                         // YYYY-MM-DDTHH:MM:SS

        // Using ZonedDateTime to get the current date and time in a specific timezone
        ZonedDateTime zonedDateTime = ZonedDateTime.now(ZoneId.of("America/New_York"));
        System.out.println("Current Date and Time in New York: " + zonedDateTime); // Output: Current Date and Time in
                                                                                   // New York:
                                                                                   // YYYY-MM-DDTHH:MM:SS-05:00[America/New_York]
    }
}