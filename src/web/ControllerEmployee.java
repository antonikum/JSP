package web;

import logic.Employee;
import logic.Model;
import logic.PersonnelUnit;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * This class provides communication between the user and system by operation with entity "Employee".
 */
public class ControllerEmployee extends HttpServlet {

    /**
     * The logger of the class.
     */
    private static final Logger LOGGER = Logger.getLogger(Model.class.getName());
    /**
     * The link in which the single object of a class is stored.
     */
    private static ControllerEmployee instance;

    private ControllerEmployee() {
    }

    /**
     * Method for initialization (in need of) the instance field.
     *
     * @return Instance of the class.
     */
    public static synchronized ControllerEmployee getInstance() {
        if (instance == null) {
            instance = new ControllerEmployee();
        }
        return instance;
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        processRequest(req, resp);
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }

        }
        LinkedList<PersonnelUnit> list = Model.getInstance().getAllUnits((page - 1) * recordsPerPage, recordsPerPage, new Employee());
        int numberOfRecords = Model.getInstance().getNumberOfRecords();
        int numberOfPages = (int) Math.ceil(numberOfRecords * 1.0 / recordsPerPage);
        req.setAttribute("employeeList", list);
        req.setAttribute("noOfPages", numberOfPages);
        req.setAttribute("currentPage", page);
        RequestDispatcher view = req.getRequestDispatcher("displayEmployees.jsp");
        view.forward(req, resp);
    }

    /**
     * The principal method of a servlet which executes all necessary actions.
     *
     * @param req  HttpServletRequest
     * @param resp HttpServletResponse
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int action = checkAction(req);

        if (action == 1) {
            Employee employee = prepareEmployee(req);
            if (employee != null) {
                try {
                    Model.getInstance().insertPersonnelUnit(employee);
                    HttpSession session = req.getSession();
                    session.setAttribute("employeeSuccessfullyAdded", "Сотрудник был успешно добавлен!");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                }
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?addEmployee");
        }

        if (action == 2) {
            if (req.getParameter("idEmployeeForUpdate") != null) {
                Employee employee = prepareEmployee(req);
                if (employee != null) {
                    try {
                        Model.getInstance().updateEmployee(employee);
                        LOGGER.log(Level.FINE, "Data of the employee were updated!");
                    } catch (SQLException e) {
                        LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                    }
                }
            } else {
                LOGGER.warning("Id is null!!(save)");
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?showEmployees&page=" + req.getParameter("pageToReturn") + "");
        }

        if (action == 3) {
            if (req.getParameter("idEmployeeToDelete") != null) {
                try {
                    Employee employee = new Employee();
                    employee.setId(Integer.parseInt(req.getParameter("idEmployeeToDelete")));
                    Model.getInstance().deletePersonnelUnit(employee);
                    LOGGER.log(Level.FINE, "The employee was removed from a database!");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                }
            } else {
                LOGGER.warning("Id Employee is null!!");
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?showEmployees&page=" + req.getParameter("pageToReturn") + "");
        }
    }

    /**
     * Method for check of the attributes of the new employee entered by the user.
     *
     * @param surName Surname of the new employee
     * @param name    Name of the new employee
     * @param salary  Salary of the new employee
     * @param date    Date of birth of the new employee
     * @return True - if the entered values of attributes approach, differently - false.
     */
    private boolean checkEmployeeValues(String surName, String name, String salary, String date) {
        boolean isValid = false;
        Pattern patternSymbolsNumbers = Pattern.compile("^[a-zа-яA-ZА-ЯёЁ-]+$");
        Matcher matcher = patternSymbolsNumbers.matcher(surName);
        if (matcher.matches() && surName.length() <= 30) {
            matcher = patternSymbolsNumbers.matcher(name);
            if (matcher.matches() && name.length() <= 30) {
                Pattern patternNumbers = Pattern.compile("^[0-9]{1,9}$");
                matcher = patternNumbers.matcher(salary);
                if (matcher.matches() && salary.length() <= 10) {
                    Pattern patternDate = Pattern.compile("^[0-9]{4}-[0-9]{2}-[0-9]{2}$");
                    matcher = patternDate.matcher(date);
                    isValid = matcher.matches();
                }
            }
        }
        return isValid;
    }

    /**
     * Method for receiving new object - the employee from these forms in request.
     *
     * @param req HttpServletRequest
     * @return New object the employee with the filled fields.
     */
    private Employee prepareEmployee(HttpServletRequest req) {
        Employee employee = new Employee();
        String surName = req.getParameter("surName");
        String name = req.getParameter("name");
        String stringSalary = req.getParameter("salary");
        String stringDob = req.getParameter("dob");
        if (checkEmployeeValues(surName, name, stringSalary, stringDob)) {
            Integer salary = Integer.parseInt(stringSalary);
            Date dob = null;
            try {
                dob = new SimpleDateFormat("yyyy-MM-dd").parse(stringDob);
            } catch (ParseException e) {
                LOGGER.log(Level.SEVERE, "Parse of Date Exception: " + e.toString() + "");
            }
            employee.setId(Integer.parseInt(req.getParameter("idEmployeeForUpdate")));
            employee.setSurname(surName);
            employee.setName(name);
            employee.setGender(req.getParameter("gender"));
            employee.setMaritalStatus(req.getParameter("maritalStatus"));
            employee.setSalary(salary);
            employee.setDob(dob);
        } else {
            employee = null;
        }
        return employee;
    }

    /**
     * The servlet what action needs to execute a method for directing.
     *
     * @param req HttpServletRequest
     * @return Int from 0 to 3.
     */
    private int checkAction(HttpServletRequest req) {
        String action = (String) req.getAttribute("action");
        if (action.equals("addEmployee")) {
            return 1;
        } else if (action.equals("updateEmployee")) {
            return 2;
        } else if (action.equals("deleteEmployee")) {
            return 3;
        }
        return 0;
    }
}