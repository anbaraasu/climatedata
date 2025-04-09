import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

//Filter by name starting with alphabet 'C'
public class FilterDemo2 {

    public static void main(String[] args) {
        List<Employee> list = new ArrayList<Employee>();
        list.add(new Employee(10, "Alex", 1010f, 'E'));
        list.add(new Employee(20, "Basha", 2020f, 'M'));
        list.add(new Employee(30, "Caterine", 3030f, 'M'));
        list.add(new Employee(40, "Dorthy", 4040f, 'C'));
        list.add(new Employee(50, "Akbar", 5050f, 'M'));
        

        System.out.println("Filter by name starting with alphabet 'A'");
        list.stream().filter((emp) -> emp.getEmpName().startsWith("A"))
                .forEach((arg) -> {
                    System.out.println(arg.getEmpName());
                });

        System.out.println("Filter salary > 3000 and display count of employees");
        Long empSalGt3000 = list.stream().filter((var) -> var.getSalary() > 3000).count();
        System.out.println(empSalGt3000);
    }
}
