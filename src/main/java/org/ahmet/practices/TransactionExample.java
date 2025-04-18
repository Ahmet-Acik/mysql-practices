package org.ahmet.practices;

import org.ahmet.utils.DatabaseUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class TransactionExample {
    public static void main(String[] args) {
        try (Connection connection = DatabaseUtil.getConnection()) {
            connection.setAutoCommit(false); // Start transaction

            try (Statement statement = connection.createStatement()) {
                // Deduct salary from one employee
                statement.executeUpdate("UPDATE employees SET salary = salary - 1000 WHERE id = 1");

                // Add salary to another employee
                statement.executeUpdate("UPDATE employees SET salary = salary + 1000 WHERE id = 2");

                connection.commit(); // Commit transaction
                System.out.println("Transaction committed successfully.");
            } catch (SQLException e) {
                connection.rollback(); // Rollback transaction on error
                System.out.println("Transaction rolled back due to error: " + e.getMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}