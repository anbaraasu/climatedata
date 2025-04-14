package com.pack;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "stud100")
public class Student {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "stu_id")
	private Integer _id;

	@Column(name = "sname")
	private String _name;

	private Integer _age;
	private LocalDate _dob;

	private String _gender;

	@Transient
	private boolean _status;

	
	// Constructor
    public Student() {
    }

    // Getters and Setters
    public Integer getId() {
        return _id;
    }

    public void setId(Integer id) {
        this._id = id;
    }
    public String getName() {
        return _name;
    }
    public void setName(String name) {
        this._name = name;
    }
    public Integer getAge() {
        return _age;
    }
    public void setAge(Integer age) {
        this._age = age;
    }
    public LocalDate getDob() {
        return _dob;
    }
    public void setDob(LocalDate dob) {
        this._dob = dob;
    }
    public String getGender() {
        return _gender;
    }
    public void setGender(String gender) {
        this._gender = gender;
    }    

}
