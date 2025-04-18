package org.ahmet.practices;

import org.ahmet.utils.DatabaseUtil;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class AdvancedSQLPractice {
    public static void main(String[] args) {
        try (Connection connection = DatabaseUtil.getConnection();
             Statement statement = connection.createStatement()) {

            // Example: Inner Join with Filtering
            String query = """
                SELECT e.name AS employee_name, d.name AS department_name, p.name AS project_name
                FROM employees e
                JOIN departments d ON e.dept_id = d.id
                JOIN employee_projects ep ON e.id = ep.employee_id
                JOIN projects p ON ep.project_id = p.id
                WHERE d.name = 'IT';
            """;

            ResultSet resultSet = statement.executeQuery(query);

            while (resultSet.next()) {
                System.out.println("Employee: " + resultSet.getString("employee_name") +
                                   ", Department: " + resultSet.getString("department_name") +
                                   ", Project: " + resultSet.getString("project_name"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}