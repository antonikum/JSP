package logic;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class "Model" - the data source (model MVC).
 * <p/>
 * Used pattern: Singletone
 *
 * @author dyakonov
 * @version 1.4
 */
public class Model {
    /**
     * The logger of the class.
     */
    private static final Logger LOGGER = Logger.getLogger(Model.class.getName());
    /**
     * The link in which the single object of a class is stored.
     */
    private static Model instance;
    /**
     * Record count in the table of a database.
     */
    private int numberOfRecords;

    private Model() {
    }

    /**
     * Method for initialization (in need of) the instance field
     *
     * @return Instance of the class
     */
    public static synchronized Model getInstance() {
        if (instance == null) {
            instance = new Model();
        }
        return instance;
    }

    /**
     * Method for obtaining the list of all objects of a certain type from a database.
     *
     * @param unit Object which all records need to be received from a database. Can be: Employee, Technology, Affair.
     * @return LinkedList of PersonnelUnits.
     */
    public LinkedList<PersonnelUnit> getAllUnits(PersonnelUnit unit) {
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        LinkedList<PersonnelUnit> personnelUnits = new LinkedList<PersonnelUnit>();
        String tableName = "";
        if (unit.getClass() == Employee.class) {
            tableName = "employees";
        } else if (unit.getClass() == Technology.class) {
            tableName = "technologies";
        } else if (unit.getClass() == Affair.class) {
            tableName = "affair";
        }
        String SQL = "SELECT * FROM " + tableName + "";
        try {
            ResultSet resultSet = dbManager.getResultSet(SQL);
            while (resultSet.next()) {
                if (unit.getClass() == Employee.class) {
                    personnelUnits.add(new Employee(resultSet));
                } else if (unit.getClass() == Technology.class) {
                    personnelUnits.add(new Technology(resultSet));
                } else if (unit.getClass() == Affair.class) {
                    personnelUnits.add(new Affair(resultSet));
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException4: " + e.toString());
        } finally {
            try {
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getConnection().isClosed()) {
                    dbManager.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
            }
        }
        return personnelUnits;
    }

    /**
     * Method for obtaining the list of objects of a certain type from a database with and to the specified line item.
     *
     * @param offset      Offset.
     * @param noOfRecords How many records (from the offset) must be received.
     * @param unit        unit Object which all records need to be received from a database. Can be: Employee, Technology, Affair.
     * @return LinkedList of PersonnelUnits.
     */
    public LinkedList<PersonnelUnit> getAllUnits(int offset, int noOfRecords, PersonnelUnit unit) {
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        LinkedList<PersonnelUnit> personnelUnits = new LinkedList<PersonnelUnit>();
        String tableName = "";
        if (unit.getClass() == Employee.class) {
            tableName = "employees";
        } else if (unit.getClass() == Technology.class) {
            tableName = "technologies";
        }
        String SQL = "select SQL_CALC_FOUND_ROWS * from " + tableName + " limit " + offset + ", " + noOfRecords;
        try {
            ResultSet resultSet = dbManager.getResultSet(SQL);
            while (resultSet.next()) {
                if (unit.getClass() == Employee.class) {
                    personnelUnits.add(new Employee(resultSet));
                } else if (unit.getClass() == Technology.class) {
                    personnelUnits.add(new Technology(resultSet));
                }
            }
            resultSet.close();
            resultSet = dbManager.getResultSet("SELECT FOUND_ROWS()");
            if (resultSet.next()) {
                this.numberOfRecords = resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException4: " + e.toString());
        } finally {
            try {
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getConnection().isClosed()) {
                    dbManager.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
            }
        }
        return personnelUnits;
    }

    /**
     * Method for obtaining the list of all technologies (skills) of the selected employee.
     *
     * @param employee The employee which skills need to be found.
     * @return LinkedList of technologies.
     */
    public LinkedList<Technology> getAllTechnologiesOfEmployee(Employee employee) {
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        LinkedList<Technology> technologies = new LinkedList<Technology>();
        int id = employee.getId();
        String SQL = "SELECT * FROM technologies AS t, affair AS a WHERE a.idEmployee = " + id + " AND t.idTechnology = a.idTechnology";
        try {
            ResultSet resultSet = dbManager.getResultSet(SQL);
            while (resultSet.next()) {
                technologies.add(new Technology(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException4: " + e.toString());
        } finally {
            try {
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getConnection().isClosed()) {
                    dbManager.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
            }
        }
        return technologies;
    }

    /**
     * Method for obtaining the list of the employees owning these technologies.
     *
     * @param technologies List of technologies.
     * @return LinkedList of employees.
     */
    public LinkedList<Employee> getAllEmployeesOfTechnologies(LinkedList<Technology> technologies) {
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        LinkedList<Employee> employees = new LinkedList<Employee>();
        int count = technologies.size();
        String SQL = "SELECT e.idEmployee, e.surname, e.name, e.gender, e.marital_status, e.salary, e.dob ";
        SQL += "FROM employees AS e, affair AS a, technologies AS t ";
        SQL += "WHERE e.idEmployee = a.idEmployee AND t.idTechnology = a.idTechnology ";
        SQL += "AND t.idTechnology IN (";
        if (count == 1) {
            SQL += "" + technologies.getFirst().getId() + ")";
        } else {
            for (int i = 0; i < technologies.size(); i++) {
                if (i == technologies.size() - 1) {
                    SQL += "" + technologies.get(i).getId() + ") ";
                } else {
                    SQL += "" + technologies.get(i).getId() + ",";
                }
            }
        }
        SQL += "GROUP BY 1 HAVING COUNT(*)=" + count + ";";
        try {
            ResultSet listOfEmployees = dbManager.getResultSet(SQL);
            while (listOfEmployees.next()) {
                employees.add(new Employee(listOfEmployees));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException(getAllEmployeesOfTechnologies): " + e.toString());
        } finally {
            try {
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getConnection().isClosed()) {
                    dbManager.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
            }
        }
        return employees;
    }

    /**
     * Method for adding of new record (the employee, technology, communication between the employee and technology) in a database.
     *
     * @param personnelUnit One of three objects: employee, technology, affair.
     * @throws SQLException
     */
    public void insertPersonnelUnit(PersonnelUnit personnelUnit) throws SQLException {
        PreparedStatement preparedStatement = null;
        MysqlDbManager mysqlDb = MysqlDbManager.getInstance();
        try {
            if (personnelUnit.getClass() == Employee.class) {
                Employee employee = (Employee) personnelUnit;
                String SQL = "INSERT INTO employees (surname, name, gender, marital_status, salary, dob) VALUES (?, ?, ?, ?, ?, ?)";
                mysqlDb.getNewConnection();
                preparedStatement = mysqlDb.getConnection().prepareStatement(SQL);
                preparedStatement.setString(1, employee.getSurname());
                preparedStatement.setString(2, employee.getName());
                preparedStatement.setString(3, employee.getGender());
                preparedStatement.setString(4, employee.getMaritalStatus());
                preparedStatement.setInt(5, employee.getSalary());
                preparedStatement.setDate(6, new Date(employee.getDob().getTime()));
                mysqlDb.executePreparedUpdate(preparedStatement);
                LOGGER.log(Level.WARNING, "The new employee was added to a database!");
            }

            if (personnelUnit.getClass() == Technology.class) {
                Technology technology = (Technology) personnelUnit;
                String SQL = "INSERT INTO technologies (name, description, rate) VALUES (?, ?, ?)";
                mysqlDb.getNewConnection();
                preparedStatement = mysqlDb.getConnection().prepareStatement(SQL);
                preparedStatement.setString(1, technology.getName());
                preparedStatement.setString(2, technology.getDescription());
                preparedStatement.setInt(3, technology.getRate());
                mysqlDb.executePreparedUpdate(preparedStatement);
                LOGGER.log(Level.WARNING, "The new technology was added to a database!");
            }

            if (personnelUnit.getClass() == Affair.class) {
                Affair affair = (Affair) personnelUnit;
                String SQL = "INSERT INTO affair (idEmployee, idTechnology) VALUES (?, ?)";
                mysqlDb.getNewConnection();
                preparedStatement = mysqlDb.getConnection().prepareStatement(SQL);
                preparedStatement.setInt(1, affair.getEmployee().getId());
                preparedStatement.setInt(2, affair.getTechnology().getId());
                mysqlDb.executePreparedUpdate(preparedStatement);
                LOGGER.log(Level.WARNING, "The new affair was added to a database!");
            }
        } catch (ClassCastException e) {
            LOGGER.log(Level.SEVERE, "ClassCastException: " + e.toString());
        } catch (NullPointerException e) {
            LOGGER.log(Level.SEVERE, "There is no access to the mysql database: " + e.toString());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (!mysqlDb.getConnection().isClosed()) {
                    mysqlDb.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
            }
        }
    }

    /**
     * Method for deleting record (the employee, technology, communication between the employee and technology) in a database.
     *
     * @param personnelUnit One of three objects: employee, technology, affair.
     * @throws SQLException
     */
    public void deletePersonnelUnit(PersonnelUnit personnelUnit) throws SQLException {
        try {
            MysqlDbManager mysqlDbManager = MysqlDbManager.getInstance();
            if (personnelUnit.getClass() == Employee.class) {
                Employee employee = (Employee) personnelUnit;
                mysqlDbManager.deleteQuery(employee.getId(), "employees");
            }
            if (personnelUnit.getClass() == Technology.class) {
                Technology technology = (Technology) personnelUnit;
                mysqlDbManager.deleteQuery(technology.getId(), "technologies");
            }
            if (personnelUnit.getClass() == Affair.class) {
                Affair affair = (Affair) personnelUnit;
                mysqlDbManager.deleteQuery(affair.getId(), "affair");
            }
        } catch (ClassCastException e) {
            LOGGER.log(Level.SEVERE, "ClassCastException" + e.toString());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        }
    }

    /**
     * Method for receiving the employee on his unique identifier.
     *
     * @param id Unique identifier of the employee in a database.
     * @return Object Employee
     */
    public Employee getEmployeeById(int id) {
        Employee foundedEmployee = null;
        String SQL = "SELECT * FROM `employees` WHERE `idEmployee` =" + id + "";
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        try {
            ResultSet resultSet = dbManager.getResultSet(SQL);
            while (resultSet.next()) {
                foundedEmployee = new Employee(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        } finally {
            try {
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
            }
        }
        return foundedEmployee;
    }

    /**
     * Method for receiving technology on its unique identifier.
     *
     * @param id Unique identifier of the technology in a database.
     * @return Object Technology
     */
    public Technology getTechnologyById(int id) {
        Technology foundedTechnology = null;
        String SQL = "SELECT * FROM `technologies` WHERE `idTechnology` =" + id + "";
        MysqlDbManager dbManager = MysqlDbManager.getInstance();
        try {
            ResultSet resultSet = dbManager.getResultSet(SQL);
            while (resultSet.next()) {
                foundedTechnology = new Technology(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        } finally {
            try {
                if (!dbManager.getPreparedStatement().isClosed()) {
                    dbManager.getPreparedStatement().close();
                }
                if (!dbManager.getResultSet().isClosed()) {
                    dbManager.getResultSet().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
            }
        }
        return foundedTechnology;
    }

    /**
     * Method for change of data on the employee
     *
     * @param employee Object Employee
     * @throws SQLException
     */
    public void updateEmployee(Employee employee) throws SQLException {
        PreparedStatement preparedStatement = null;
        MysqlDbManager mysqlDb = MysqlDbManager.getInstance();
        String SQL = "UPDATE employees SET surname=?, name=?, gender=?, marital_status=?, salary=?, dob=? WHERE idEmployee=?";
        try {
            mysqlDb.getNewConnection();
            preparedStatement = mysqlDb.getConnection().prepareStatement(SQL);
            preparedStatement.setString(1, employee.getSurname());
            preparedStatement.setString(2, employee.getName());
            preparedStatement.setString(3, employee.getGender());
            preparedStatement.setString(4, employee.getMaritalStatus());
            preparedStatement.setInt(5, employee.getSalary());
            preparedStatement.setDate(6, new Date(employee.getDob().getTime()));
            preparedStatement.setInt(7, employee.getId());
            mysqlDb.executePreparedUpdate(preparedStatement);
        } catch (NullPointerException e) {
            LOGGER.log(Level.SEVERE, "There is no access to the mysql database: " + e.toString());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (!mysqlDb.getConnection().isClosed()) {
                    mysqlDb.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
            }
        }
    }

    /**
     * Method for change of data on the technology in database.
     *
     * @param technology Object Technology
     * @throws SQLException
     */
    public void updateTechnology(Technology technology) throws SQLException {
        PreparedStatement preparedStatement = null;
        MysqlDbManager mysqlDb = MysqlDbManager.getInstance();
        String SQL = "UPDATE technologies SET name=?, description=?, rate=? WHERE idTechnology=?";
        try {
            mysqlDb.getNewConnection();
            preparedStatement = mysqlDb.getConnection().prepareStatement(SQL);
            preparedStatement.setString(1, technology.getName());
            preparedStatement.setString(2, technology.getDescription());
            preparedStatement.setInt(3, technology.getRate());
            preparedStatement.setInt(4, technology.getId());
            mysqlDb.executePreparedUpdate(preparedStatement);
        } catch (NullPointerException e) {
            LOGGER.log(Level.SEVERE, "There is no access to the mysql database: " + e.toString());
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
                if (!mysqlDb.getConnection().isClosed()) {
                    mysqlDb.getConnection().close();
                }
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException" + e.toString());
            }
        }
    }

    public int getNumberOfRecords() {
        return numberOfRecords;
    }
}