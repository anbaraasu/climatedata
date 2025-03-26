public class FunctionalInterfaceDemo {
    public static void main(String[] args) {
        Calculator c = (a,b)->{ if (a >0 && b>0){return a +b;};System.out.println("Provide non negative values for a and b");return 0;};
        System.out.println("Add:"+ c.add(-100,200));

        c = (a,b)->{return a*b;};
        System.out.println("Multi:"+ c.add(100,200));
    }
}

//SAM - single abstract method in functional interface
@FunctionalInterface
interface Calculator{
    int add(int a, int b);
}
