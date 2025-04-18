package org.ahmet.utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DatabaseUtil {
    private static final Logger LOGGER = Logger.getLogger(DatabaseUtil.class.getName());
    private static final Properties PROPERTIES = new Properties();

    static {
        try (InputStream input = DatabaseUtil.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input == null) {
                throw new RuntimeException("Unable to find config.properties");
            }
            PROPERTIES.load(input);
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Failed to load database configuration: {0}", e.getMessage());
            throw new RuntimeException("Error loading database configuration", e);
        }
    }

    public static Connection getConnection() {
        try {
            String url = PROPERTIES.getProperty("database.url");
            String user = PROPERTIES.getProperty("database.user");
            String password = PROPERTIES.getProperty("database.password");
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Failed to establish database connection: {0}", e.getMessage());
            throw new RuntimeException("Error connecting to the database", e);
        }
    }
}