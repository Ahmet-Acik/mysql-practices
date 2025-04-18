package org.ahmet.practices;

import org.ahmet.utils.DatabaseUtil;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TransactionExample {
    private static final Logger LOGGER = Logger.getLogger(TransactionExample.class.getName());

    private static final String DEDUCT_SALARY_QUERY = "UPDATE employees SET salary = salary - 1000 WHERE id = 1";
    private static final String ADD_SALARY_QUERY = "UPDATE employees SET salary = salary + 1000 WHERE id = 2";

    public static void main(String[] args) {
        try (Connection connection = DatabaseUtil.getConnection()) {
            connection.setAutoCommit(false); // Start transaction

            try (Statement statement = connection.createStatement()) {
                // Deduct salary from one employee
                statement.executeUpdate(DEDUCT_SALARY_QUERY);

                // Add salary to another employee
                statement.executeUpdate(ADD_SALARY_QUERY);

                connection.commit(); // Commit transaction
                LOGGER.info("Transaction committed successfully.");
            } catch (SQLException e) {
                connection.rollback(); // Rollback transaction on error
                LOGGER.log(Level.SEVERE, "Transaction rolled back due to error: {0}", e.getMessage());
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "An unexpected error occurred: {0}", e.getMessage());
        }
    }
}