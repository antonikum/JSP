package logic;

import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Entity technology
 */
public class Technology implements PersonnelUnit {
    private int id;
    private String name;
    private String description;
    private int rate;

    public Technology(ResultSet resultSet) throws SQLException {
        setId(resultSet.getInt(1));
        setName(resultSet.getString(2));
        setDescription(resultSet.getString(3));
        setRate(resultSet.getInt(4));
    }

    public Technology() {
    }

    @Override
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }
}
