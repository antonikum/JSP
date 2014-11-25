package logic;

import java.sql.ResultSet;
import java.sql.SQLException;


/**
 * Class for representation of communication between the employee and technology as an application object.
 */
public class Affair implements PersonnelUnit {
    private int id;
    private Employee employee;
    private Technology technology;

    public Affair(ResultSet resultSet) throws SQLException {
        setId(resultSet.getInt(1));
        setEmployee(Model.getInstance().getEmployeeById(resultSet.getInt(2)));
        setTechnology(Model.getInstance().getTechnologyById(resultSet.getInt(3)));
    }

    public Affair() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Employee getEmployee() {
        return employee;
    }

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Technology getTechnology() {
        return technology;
    }

    public void setTechnology(Technology technology) {
        this.technology = technology;
    }
}
