package web;

import logic.Model;
import logic.PersonnelUnit;
import logic.Technology;

import javax.servlet.RequestDispatcher;
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
 * This class provides communication between the user and system by operation with entity "Technology".
 */
public class ControllerTechnology extends HttpServlet {

    /**
     * The logger of the class.
     */
    private static final Logger LOGGER = Logger.getLogger(Model.class.getName());
    /**
     * The link in which the single object of a class is stored.
     */
    private static ControllerTechnology instance;

    private ControllerTechnology() {
    }

    /**
     * Method for initialization (in need of) the instance field.
     *
     * @return Instance of the class.
     */
    public static synchronized ControllerTechnology getInstance() {
        if (instance == null) {
            instance = new ControllerTechnology();
        }
        return instance;
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        int recordsPerPage = 10;
        if (req.getParameter("pageTech") != null) {
            try {
                page = Integer.parseInt(req.getParameter("pageTech"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        LinkedList<PersonnelUnit> list = Model.getInstance().getAllUnits((page - 1) * recordsPerPage, recordsPerPage, new Technology());
        int numberOfRecords = Model.getInstance().getNumberOfRecords();
        int numberOfPages = (int) Math.ceil(numberOfRecords * 1.0 / recordsPerPage);
        req.setAttribute("technologyList", list);
        req.setAttribute("noOfPages", numberOfPages);
        req.setAttribute("currentPage", page);
        RequestDispatcher view = req.getRequestDispatcher("displayTechnologies.jsp");
        view.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        processRequest(req, resp);
    }

    /**
     * The principal method of a servlet which executes all necessary actions for action Post.
     *
     * @param req  HttpServletRequest
     * @param resp HttpServletResponse
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int action = checkAction(req);

        if (action == 1) {
            Technology technology = prepareTechnology(req);
            if (technology != null) {
                try {
                    Model.getInstance().insertPersonnelUnit(technology);
                    HttpSession session = req.getSession();
                    session.setAttribute("technologySuccessfullyAdded", "Новая технология была успешно добавлена!");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                }
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?addTechnology");
        }

        if (action == 2) {
            if (req.getParameter("idTechnologyForUpdate") != null) {
                Technology technology = prepareTechnology(req);
                if (technology != null) {
                    try {
                        Model.getInstance().updateTechnology(technology);
                        LOGGER.log(Level.FINE, "Data of the technology were updated!");
                    } catch (SQLException e) {
                        LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                    }
                }
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?showTechnologies&pageTech=" + req.getParameter("pageToReturnTechnology") + "");
        }

        if (action == 3) {
            if (req.getParameter("idTechnology") != null) {
                try {
                    Technology technology = new Technology();
                    technology.setId(Integer.parseInt(req.getParameter("idTechnology")));
                    Model.getInstance().deletePersonnelUnit(technology);
                    LOGGER.log(Level.FINE, "The technology was removed from a database!");
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString() + "");
                }
            } else {
                LOGGER.warning("Id Technology is null!!");
            }
            req.setCharacterEncoding("UTF-8");
            resp.sendRedirect("main?showTechnologies&pageTech=" + req.getParameter("pageToReturnTechnology") + "");
        }
    }

    /**
     * Method for verification of data of the new technology entered by the user.
     *
     * @param name        Name of technology.
     * @param description Description of technology.
     * @return True - if the entered values of attributes approach, differently - false.
     */
    private boolean checkTechnologyValues(String name, String description) {
        boolean isValid = false;
        if (name.length() <= 100) {
            isValid = description.length() <= 200;
        }
        return isValid;
    }

    /**
     * Method for receiving new object - the technology from these forms in request.
     *
     * @param req HttpServletRequest
     * @return New object the technology with the filled fields.
     */
    private Technology prepareTechnology(HttpServletRequest req) {
        Technology technology = new Technology();
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String stringRate = req.getParameter("rate");
        if (checkTechnologyValues(name, description)) {
            technology.setId(Integer.parseInt(req.getParameter("idTechnologyForUpdate")));
            technology.setName(name);
            technology.setDescription(description);
            technology.setRate(Integer.parseInt(stringRate));
        } else {
            technology = null;
        }
        return technology;
    }

    /**
     * The servlet what action needs to execute a method for directing.
     *
     * @param req HttpServletRequest
     * @return Int from 0 to 3.
     */
    private int checkAction(HttpServletRequest req) {
        String action = (String) req.getAttribute("action");
        if (action.equals("addTechnology")) {
            return 1;
        } else if (action.equals("updateTechnology")) {
            return 2;
        } else if (action.equals("deleteTechnology")) {
            return 3;
        }
        return 0;
    }
}