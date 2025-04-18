package org.ahmet.practices;

import org.ahmet.utils.DatabaseUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AdvancedSQLPractice {
    private static final Logger LOGGER = Logger.getLogger(AdvancedSQLPractice.class.getName());
    private static final String QUERY = """
                SELECT e.name AS employee_name, d.name AS department_name, p.name AS project_name
                FROM employees e
                JOIN departments d ON e.dept_id = d.id
                JOIN employee_projects ep ON e.id = ep.employee_id
                JOIN projects p ON ep.project_id = p.id
                WHERE d.name = 'IT';
            """;

    public static void main(String[] args) {
        try (Connection connection = DatabaseUtil.getConnection();
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(QUERY)) {

            while (resultSet.next()) {
                try {
                    String employeeName = resultSet.getString("employee_name");
                    String departmentName = resultSet.getString("department_name");
                    String projectName = resultSet.getString("project_name");

                    LOGGER.info(() -> String.format("Employee: %s, Department: %s, Project: %s",
                            employeeName, departmentName, projectName));
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "Error retrieving data from ResultSet: {0}", e.getMessage());
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "An error occurred while executing the query: {0}", e.getMessage());
        }
    }
}