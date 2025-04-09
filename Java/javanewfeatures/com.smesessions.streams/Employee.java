public class Employee {
	private int empNo;
	private String empName;
	private float salary;
	private char band;
	public Employee() {
		super();
	}
	public Employee(int empNo, String empName, float salary, char band) {
		super();
		this.empNo = empNo;
		this.empName = empName;
		this.salary = salary;
		this.band = band;
	}
    //generate Setter, Getter, toString methods
    public int getEmpNo() {
        return empNo;
    }

    public void setEmpNo(int empNo) {
        this.empNo = empNo;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public float getSalary() {
        return salary;
    }

    public void setSalary(float salary) {
        this.salary = salary;
    }

    public char getBand() {
        return band;
    }

    public void setBand(char band) {
        this.band = band;
    }

    @Override
    public String toString() {
        return "Employee [empNo=" + empNo + ", empName=" + empName + ", salary=" + salary + ", band=" + band + "]";
    }
}
