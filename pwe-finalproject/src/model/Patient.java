package model;

import java.util.Date;

public class Patient {
    private int id;
    private String name;
    private Date dateOfBirth;
    private int age;
    private double height;
    private double weight;
    private String bloodType;

    public Patient(int id, String name, Date dateOfBirth, int age, double height, double weight, String bloodType) {
        this.id = id;
        this.name = name;
        this.dateOfBirth = dateOfBirth;
        this.age = age;
        this.height = height;
        this.weight = weight;
        this.bloodType = bloodType;
    }

    // Getter and setter methods for id, name, and age

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public double getHeight() {
		return height;
	}

	public void setHeight(double height) {
		this.height = height;
	}

	public double getWeight() {
		return weight;
	}

	public void setWeight(double weight) {
		this.weight = weight;
	}

	public String getBloodType() {
		return bloodType;
	}

	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}
}
