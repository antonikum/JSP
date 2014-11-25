package logic;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class is used as a manager to work with Mysql database.
 * <p/>
 * Used pattern: Singletone
 *
 * @author dyakonov
 */
public class MysqlDbManager {

    /**
     * The logger of the class.
     */
    private static final Logger LOGGER = Logger.getLogger(MysqlDbManager.class.getName());
    /**
     * The link in which the single object of a class is stored.
     */
    private static MysqlDbManager instance;
    /**
     * Data source - from it a class receives data for creation of connection to a database.
     */
    private static DataSource dataSource;
    /**
     * Connection to a database.
     */
    private Connection connection = null;
    private Statement statement = null;
    private PreparedStatement preparedStatement = null;
    private ResultSet resultSet = null;

    private MysqlDbManager() {
    }

    /**
     * Method for initialization (in need of) the instance field
     *
     * @return Instance of the class.
     */
    public static synchronized MysqlDbManager getInstance() {
        if (instance == null) {
            try {
                instance = new MysqlDbManager();
                Context ctx = new InitialContext();
                instance.dataSource = (DataSource) ctx.lookup("java:comp/env/jdbc/EmployeeDS");
                instance.getNewConnection();
            } catch (NamingException e) {
                LOGGER.log(Level.SEVERE, "NamingException" + e.toString() + "");
            }
        }
        return instance;
    }

    /**
     * Method for deleting record from a database.
     *
     * @param id        Unique identifier of object for deleting (shall be in the first column of the table).
     * @param tableName The name of the table from which it is necessary to delete record.
     * @throws SQLException
     */
    public void deleteQuery(int id, String tableName) throws SQLException {
        try {
            if (connection.isClosed()) {
                getNewConnection();
            }
            statement = connection.createStatement(ResultSet.TYPE_FORWARD_ONLY, ResultSet.CONCUR_UPDATABLE);
            resultSet = statement.executeQuery("SELECT * FROM " + tableName + "");
            if (resultSet.getConcurrency() == ResultSet.CONCUR_READ_ONLY) {
                LOGGER.severe("The table " + tableName + " is blocked!");
            } else {
                while (resultSet.next()) {
                    Integer idDB = resultSet.getInt(1);
                    if (idDB == id) {
                        resultSet.deleteRow();
                        if (LOGGER.isLoggable(Level.FINE)) {
                            LOGGER.log(Level.FINE, "The object from " + tableName + " was deleted from database!", id);
                        }
                        break;
                    }
                }
            }
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
                }
            }
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
                }
            }
        }
    }

    /**
     * Update query of a database  (INSERT, UPDATE, CREATE TABLE etc) with use Prepared Statement.
     *
     * @param preparedStatement Prepared Statement.
     */
    public void executePreparedUpdate(PreparedStatement preparedStatement) {
        try {
            preparedStatement.execute();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
                }
            }
        }
    }

    /**
     * Method for data sampling from a database.
     *
     * @param sql SQL query.
     * @return ResultSet - Result of selection
     */
    public ResultSet getResultSet(String sql) {
        try {
            if (connection.isClosed()) {
                getNewConnection();
            }
            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
        }
        return resultSet;
    }

    public PreparedStatement getPreparedStatement() {
        return preparedStatement;
    }

    public ResultSet getResultSet() {
        return resultSet;
    }

    public Connection getConnection() {
        return connection;
    }

    /**
     * Method for creation of new connection.
     */
    public void getNewConnection() {
        try {
            connection = dataSource.getConnection();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException: " + e.toString());
        }
    }
}