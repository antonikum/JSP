package web;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Principal controller of application. He decides as well as where to execute the required action.
 */
public class MainController extends HttpServlet {

    public MainController() {
        super();
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        processRequestPost(req, resp);
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        processRequestGet(req, resp);
    }

    /**
     * The main method of a servlet which executes all necessary actions for the operation Post.
     *
     * @param req  HttpServletRequest
     * @param resp HttpServletResponse
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequestPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int action = checkActionPost(req);

        if (action == 0) {
            resp.sendRedirect("404.jsp");
        }

        if (action == 1) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "addEmployee");
            ControllerEmployee.getInstance().doPost(req, resp);
        }

        if (action == 2) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "updateEmployee");
            ControllerEmployee.getInstance().doPost(req, resp);
        }

        if (action == 3) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "deleteEmployee");
            ControllerEmployee.getInstance().doPost(req, resp);
        }

        if (action == 4) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "addTechnology");
            ControllerTechnology.getInstance().doPost(req, resp);
        }

        if (action == 5) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "updateTechnology");
            ControllerTechnology.getInstance().doPost(req, resp);
        }

        if (action == 6) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "deleteTechnology");
            ControllerTechnology.getInstance().doPost(req, resp);
        }

        if (action == 7) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "showTechnologies");
            ControllerAffair.getInstance().doPost(req, resp);
        }

        if (action == 8) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "addNewAffairToEmployee");
            ControllerAffair.getInstance().doPost(req, resp);
        }

        if (action == 9) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "deleteAffairOffEmployee");
            ControllerAffair.getInstance().doPost(req, resp);
        }
        if (action == 10) {
            req.setCharacterEncoding("UTF-8");
            req.setAttribute("action", "searchEmployeesOfTechnologies");
            ControllerAffair.getInstance().doPost(req, resp);
        }
    }

    /**
     * The main method of a servlet which executes all necessary actions for the operation Get.
     *
     * @param req  HttpServletRequest
     * @param resp HttpServletResponse
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequestGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int action = checkActionGet(req);

        if (action == 0) {
            resp.sendRedirect("404.jsp");
        }

        if (action == 1) {
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("addEmployee.jsp").forward(req, resp);
        }

        if (action == 2) {
            req.setCharacterEncoding("UTF-8");
            req.getRequestDispatcher("addTechnology.jsp").forward(req, resp);
        }

        if (action == 3) {
            req.setCharacterEncoding("UTF-8");
            ControllerEmployee.getInstance().doGet(req, resp);
        }

        if (action == 4) {
            req.setCharacterEncoding("UTF-8");
            ControllerTechnology.getInstance().doGet(req, resp);
        }

        if (action == 5) {
            req.setCharacterEncoding("UTF-8");
            ControllerAffair.getInstance().doGet(req, resp);
        }
    }

    /**
     * Defines what action it is necessary to make for the operation Post.
     *
     * @param req HttpServletRequest
     * @return code of operation.
     */
    private int checkActionPost(HttpServletRequest req) {
        if (req.getParameter("addEmployeeButton") != null) {
            return 1;
        } else if (req.getParameter("saveEmployeeValuesButton") != null) {
            return 2;
        } else if (req.getParameter("buttonDeleteEmployee") != null) {
            return 3;
        } else if (req.getParameter("addTechnologyButton") != null) {
            return 4;
        } else if (req.getParameter("saveTechnologyValuesButton") != null) {
            return 5;
        } else if (req.getParameter("buttonDeleteTechnology") != null) {
            return 6;
        } else if (req.getParameter("buttonEditAffairs") != null) {
            return 7;
        } else if (req.getParameter("buttonAddTechnologyToEmployee") != null) {
            return 8;
        } else if (req.getParameter("buttonDeleteTechnologyEmployee") != null) {
            return 9;
        } else if (req.getParameter("buttonSearchEmployees") != null) {
            return 10;
        }
        return 0;
    }

    /**
     * Defines what action it is necessary to make for the operation Get.
     *
     * @param req HttpServletRequest
     * @return code of operation.
     */
    private int checkActionGet(HttpServletRequest req) {
        if (req.getParameter("addEmployee") != null) {
            return 1;
        } else if (req.getParameter("addTechnology") != null) {
            return 2;
        } else if (req.getParameter("showEmployees") != null) {
            return 3;
        } else if (req.getParameter("showTechnologies") != null) {
            return 4;
        } else if (req.getParameter("searchEmployees") != null) {
            return 5;
        }
        return 0;
    }
}