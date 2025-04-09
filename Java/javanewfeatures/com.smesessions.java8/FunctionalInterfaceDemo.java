



//SAM - single abstract method in functional interface
@FunctionalInterface
interface Calculator{
    int add(int a, int b);
}

public class FunctionalInterfaceDemo {
    public static void main(String[] args) {
        Calculator c = (a,b)->a+b;

        System.out.println("Add:"+ c.add(100,200));

        c = (a, b)->{return a*b;};
        System.out.println("Multi:"+ c.add(100,200));
    }
}