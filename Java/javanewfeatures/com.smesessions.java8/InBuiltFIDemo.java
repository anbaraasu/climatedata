import java.util.function.BiFunction;
import java.util.function.Supplier;
import java.util.function.Consumer;
import java.util.function.BiConsumer;

/*
 * From Java 8: Now interface can have static, default, private methods and Concrete methods.
 */

class CalculatorFI {
    // Represents a function that takes two arguments of types T and U, and returns
    // a result of type R.

    public Integer calc(BiFunction<Integer, Integer, Integer> bi,
            Integer num1, Integer num2) {
        return bi.apply(num1, num2);
    }
}

public class InBuiltFIDemo {
    public static void main(String[] args) {
        CalculatorFI calculator = new CalculatorFI();
        Integer ans = calculator.calc((x, y) -> x + y, 10, 5);
        System.out.println("BiFunction Output:" + ans);

        // This function returns a random value. 
        Supplier<Double> randomValue = () -> Math.random(); 
  
        // Print the random value using get() 
        System.out.println("Supplier Random Output:" + randomValue.get()); 

        Consumer<String> consumer = (s) -> System.out.println("Consumer Output:" + s);
        consumer.accept("Hello, Consumer!");
        
        BiConsumer<String, String> biconsumer = (s1,s2) -> System.out.println(s1 + s2);
        biconsumer.accept("Bi Consumer Output:", "Finally worked");
        
        // Method reference to a static method
        MethodReferenceToPrintln methodRef = System.out::println;
        methodRef.display("Hello, InBuilt Method Reference!");

        MethodReferenceToPrintln2 methodRef2 = new MethodReferenceToPrintlnImpl()::display;
        methodRef2.display("Hello, ", "Our Own Method Reference");
    }
}


@FunctionalInterface
interface MethodReferenceToPrintln {
    void display(String s);
}

@FunctionalInterface
interface MethodReferenceToPrintln2 {
    void display(String s1, String s2);
}

class MethodReferenceToPrintlnImpl implements MethodReferenceToPrintln2 {
    @Override
    public void display(String s1, String s2) {
        System.out.println(s1 + s2);
    }
}