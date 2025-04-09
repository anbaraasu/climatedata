
@FunctionalInterface
public interface MultiInterface {

    public String sayHello(String name);

    public static int add(int num1, int num2) {
        return num1 + num2;
    }

    // Re-declaration of the equals() method in the Object class
    boolean equals(Object obj);

    default public int defaultMethod(int variable) {
        return variable + 100;
    }
}

public class MultiInterfaceDemo {
    public static void main(String[] args) {
        MultiInterface myInterface1 = (name) -> (name + " World");
        // Logic of sayHello
        System.out.println(myInterface1.sayHello("Hello"));
        // Accessing static method
        System.out.println(MultiInterface.add(1, 2));
        // Accessing default method
        System.out.println(myInterface1.defaultMethod(10));
        // another interface object
        MultiInterface myInterface2 = (name) -> (name + " World");
        // Accessing the equals method
        System.out.println(myInterface1.equals(myInterface2));
    }
}
