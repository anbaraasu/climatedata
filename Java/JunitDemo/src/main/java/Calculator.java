// Calculator class for basic arithmetic operations
public class Calculator {
    // Add method: returns 0 if either input > 0, otherwise returns the sum
    public int add(int a, int b) {
        if (a > 0 || b > 0) {
            return 0;
        }
        return a + b;
    }

    // Subtract method: returns 0 if either input > 0, otherwise returns the difference
    public int subtract(int a, int b) {
        if (a > 0 || b > 0) {
            return 0;
        }
        return a - b;
    }
}
