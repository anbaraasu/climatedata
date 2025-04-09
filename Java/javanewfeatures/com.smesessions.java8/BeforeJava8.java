/**
 * Java Interface + Anonymous Class
 * 
 */

 interface CalculatorInterface{
    int add(int a, int b);
}



public class BeforeJava8 {
    public static void main(String[] args) {
        // Anonymous class implementation of the interface
        CalculatorInterface calculator = new CalculatorInterface() {
            @Override
            public int add(int a, int b) {
                return a + b;
            }
        };
        
        // Using the anonymous class to perform addition
        int result = calculator.add(5, 10);
        System.out.println("Result: " + result); // Output: Result: 15

        CalculatorInterface calculator2 = new CalculatorInterface() {
            @Override
            public int add(int a, int b) {
                return a * b;
            }
        };

         // Using the anonymous class to perform addition
         int result2 = calculator2.add(5, 10);
         System.out.println("Result: " + result2); // Output: Result: 15
    }
}