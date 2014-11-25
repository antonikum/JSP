package logic;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Collator;
import java.util.Date;
import java.util.Locale;

/**
 * The class is used for representation of the employee as object in the application.
 */
public class Employee implements Comparable, PersonnelUnit {
    private int id;
    private String surname;
    private String name;
    private String gender;
    private String maritalStatus;
    private Integer salary;
    private Date dob;

    public Employee() {
    }

    public Employee(ResultSet resultSet) throws SQLException {
        setId(resultSet.getInt(1));
        setSurname(resultSet.getString(2));
        setName(resultSet.getString(3));
        setGender(resultSet.getString(4));
        setMaritalStatus(resultSet.getString(5));
        setSalary(resultSet.getInt(6));
        setDob(resultSet.getDate(7));
    }

    @Override
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getMaritalStatus() {
        return maritalStatus;
    }

    public void setMaritalStatus(String maritalStatus) {
        this.maritalStatus = maritalStatus;
    }

    public Integer getSalary() {
        return salary;
    }

    public void setSalary(Integer salary) {
        this.salary = salary;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "surname='" + surname + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", maritalStatus='" + maritalStatus + '\'' +
                ", salary=" + salary +
                ", dob=" + dob +
                '}';
    }

    public int compareTo(Object obj) {
        Collator c = Collator.getInstance(new Locale("ru"));
        c.setStrength(Collator.PRIMARY);
        return c.compare(this.toString(), obj.toString());
    }
}