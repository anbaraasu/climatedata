/**
 * Method References in Java 8: Method references are a shorthand notation of a lambda expression to call a method. 
 * They are used to refer to methods by their names instead of executing them directly. 
 * Method references can be used to refer to static methods, instance methods, and constructors.
 * 
 */


 class MethodReferences{
    public static void main(String[] args) {
        // Using a method reference to refer to a static method
        CalculatorInterface calculator = MethodReferences::add;
        int result = calculator.add(5, 10);
        System.out.println("Result: " + result); // Output: Result: 15

    }
}