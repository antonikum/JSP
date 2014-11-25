package web;

import logic.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class provides communication between the user and system by operation with entity "Affair".
 */
public class ControllerAffair extends HttpServlet {

    /**
     * The logger of the class.
     */
    private static final Logger LOGGER = Logger.getLogger(Model.class.getName());
    /**
     * The link in which the single object of a class is stored.
     */
    private static ControllerAffair instance;

    private ControllerAffair() {
    }

    /**
     * Method for initialization (in need of) the instance field.
     *
     * @return Instance of the class.
     */
    public static synchronized ControllerAffair getInstance() {
        if (instance == null) {
            instance = new ControllerAffair();
        }
        return instance;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        processRequest(req, resp);
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LinkedList<PersonnelUnit> allTechnologies = Model.getInstance().getAllUnits(new Technology());
        HttpSession session = req.getSession();
        session.setAttribute("AllTechnologies", allTechnologies);
        req.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("searchEmployees.jsp").forward(req, resp);
    }

    /**
     * The principal method of a servlet which executes all necessary actions for action Post.
     *
     * @param req  HttpServletRequest
     * @param resp HttpServletResponse
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int action = checkAction(req);

        if (action == 1) {
            req = setListsOfTechnologiesEmployee(req);
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("technologiesOfEmployee.jsp").forward(req, resp);
        }

        if (action == 2) {
            Affair affair = prepareAffair(req);
            try {
                Model.getInstance().insertPersonnelUnit(affair);
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
            }
            req = setListsOfTechnologiesEmployee(req);
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("technologiesOfEmployee.jsp").forward(req, resp);
        }

        if (action == 3) {
            Affair affair = prepareAffair(req);
            for (PersonnelUnit unit : Model.getInstance().getAllUnits(new Affair())) {
                Affair affairInDb = (Affair) unit;
                if (affair.getEmployee().getId() == affairInDb.getEmployee().getId() &&
                        affair.getTechnology().getId() == affairInDb.getTechnology().getId()) {
                    affair.setId(affairInDb.getId());
                }
            }
            try {
                Model.getInstance().deletePersonnelUnit(affair);
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
            }
            req = setListsOfTechnologiesEmployee(req);
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("technologiesOfEmployee.jsp").forward(req, resp);
        }

        if (action == 4) {
            String[] selectedTechnologiesId = req.getParameterValues("idTechnologies");
            LinkedList<Technology> technologies = new LinkedList<Technology>();
            for (String stringId : selectedTechnologiesId) {
                int id = Integer.parseInt(stringId);
                technologies.add(Model.getInstance().getTechnologyById(id));
            }
            LinkedList<PersonnelUnit> allTechnologies = Model.getInstance().getAllUnits(new Technology());
            LinkedList<Employee> employees = Model.getInstance().getAllEmployeesOfTechnologies(technologies);
            HttpSession session = req.getSession();
            session.setAttribute("ListOfEmployees", employees);
            session.setAttribute("AllTechnologies", allTechnologies);
            session.setAttribute("ListOfTechnologies", technologies);
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("searchEmployees.jsp").forward(req, resp);
        }
    }

    /**
     * Method for initialization of lists of technologies and employees.
     *
     * @param req HttpServletRequest
     * @return HttpServletRequest
     */
    private HttpServletRequest setListsOfTechnologiesEmployee(HttpServletRequest req) {
        String stringId = req.getParameter("idEmployeeEditTechnologies");
        if (stringId.length() > 0) {
            Employee employee = Model.getInstance().getEmployeeById(Integer.parseInt(stringId));
            LinkedList<Technology> technologiesOfTheEmployee = Model.getInstance().getAllTechnologiesOfEmployee(employee);
            LinkedList<Technology> technologiesNotOfTheEmployee = new LinkedList<Technology>();
            for (PersonnelUnit technologyInDb : Model.getInstance().getAllUnits(new Technology())) {
                boolean founded = false;
                for (Technology technologyOfEmployee : technologiesOfTheEmployee) {
                    if (technologyOfEmployee.getId() == technologyInDb.getId()) {
                        founded = true;
                        break;
                    }
                }
                if (!founded) {
                    technologiesNotOfTheEmployee.add((Technology) technologyInDb);
                }
            }
            HttpSession session = req.getSession();
            session.setAttribute("employeeShowTechnologies", employee);
            session.setAttribute("technologiesOfTheEmployee", technologiesOfTheEmployee);
            session.setAttribute("technologiesNotOfTheEmployee", technologiesNotOfTheEmployee);
        }
        return req;
    }

    /**
     * Method for receiving new object - the affair from these forms in request.
     *
     * @param req HttpServletRequest
     * @return New object the affair with the filled fields.
     */
    private Affair prepareAffair(HttpServletRequest req) {
        Affair affair = new Affair();
        HttpSession session = req.getSession();
        Employee employee = (Employee) session.getAttribute("employeeShowTechnologies");
        String idTechnology = req.getParameter("idTechnology");
        Technology technology = Model.getInstance().getTechnologyById(Integer.parseInt(idTechnology));
        affair.setTechnology(technology);
        affair.setEmployee(employee);
        return affair;
    }

    /**
     * The servlet what action needs to execute a method for directing.
     *
     * @param req HttpServletRequest
     * @return Int from 0 to 4.
     */
    private int checkAction(HttpServletRequest req) {
        String action = (String) req.getAttribute("action");
        if (action.equals("showTechnologies")) {
            return 1;
        } else if (action.equals("addNewAffairToEmployee")) {
            return 2;
        } else if (action.equals("deleteAffairOffEmployee")) {
            return 3;
        } else if (action.equals("searchEmployeesOfTechnologies")) {
            return 4;
        }
        return 0;
    }
}