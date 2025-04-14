package com.pack;

import javax.persistence.*;
import java.time.LocalDate;

public class Main {
	public static void main(String[] args) {
		EntityManagerFactory emf = Persistence.createEntityManagerFactory("student-info");
		EntityManager em = emf.createEntityManager();
		EntityTransaction et = em.getTransaction();

		et.begin();

		// Example: Insert a Student
		Student st = new Student();
		st.setName("John");
		st.setAge(22);
		st.setDob(LocalDate.parse("2000-01-01"));
		st.setGender("Male");
		em.persist(st);

		et.commit();
		System.out.println("Success");

        // retreive the student by name John
		//JQL , HQL - field name and class name 
        TypedQuery<Student> query = em.createQuery("SELECT s FROM Student s WHERE s._name = :name", Student.class);
        query.setParameter("name", "John");
        Student student = query.getSingleResult();
        System.out.println("Student ID: " + student.getId());
        System.out.println("Student Name: " + student.getName());
        System.out.println("Student Age: " + student.getAge());
        System.out.println("Student DOB: " + student.getDob());

        

		em.close();
		emf.close();
	}
}
