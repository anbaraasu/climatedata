import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

// Test suite for Calculator class
public class CalculatorTest {
    private final Calculator calculator = new Calculator();

    @Test
    public void testAdd() {
        // Test cases for add method
        assertEquals(0, calculator.add(2, 0));
        assertEquals(0, calculator.add(0, 2));
        assertEquals(2, calculator.add(1, 1));
        assertEquals(0, calculator.add(2, 2));
    }

    @Test
    public void testSubtract() {
        // Test cases for subtract method
        assertEquals(0, calculator.subtract(2, 0));
        assertEquals(0, calculator.subtract(0, 2));
        assertEquals(0, calculator.subtract(2, 2));
        assertEquals(0, calculator.subtract(1, 2));
        assertEquals(0, calculator.subtract(2, 1));
    }
}
