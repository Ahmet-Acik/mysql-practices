# SQL Practice with Java

This project is designed to help developers practice SQL concepts using a Java application. It includes a MySQL database schema, sample data, and Java code to execute and test SQL queries, covering basic to advanced topics like joins, subqueries, and transactions.

## Features

- **Database Schema**: Logical tables with relationships for practicing SQL.
- **SQL Concepts**: Covers basics, filtering, sorting, joins, grouping, subqueries, transactions, and more.
- **Java Integration**: Execute SQL queries using Java with JDBC.
- **Best Practices**: Organized project structure and reusable utility classes.

## Prerequisites

- **Java**: JDK 17 or later
- **MySQL**: Version 8.0 or later
- **Maven**: For dependency management
- **IntelliJ IDEA**: Recommended IDE

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   ├── org/ahmet/
│   │   │   ├── practices/
│   │   │   │   ├── AdvancedSQLPractice.java
│   │   │   │   ├── TransactionExample.java
│   │   │   ├── utils/
│   │   │   │   ├── DatabaseUtil.java
│   ├── resources/
│   ├── sql/
│   │   ├── ddl.sql
│   │   ├── dml.sql
```

## Setup Instructions

### 1. Clone the Repository
```bash
git clone <repository-url>
cd <repository-folder>
```

### 2. Configure MySQL Database
1. Create the database and tables using the `src/main/java/org/ahmet/queries/ddl.sql` file.
   ```sql
   CREATE DATABASE IF NOT EXISTS sql_practice;
   USE sql_practice;
   -- Run the rest of the DDL script
   ```
2. Populate the database with sample data using the `src/main/java/org/ahmet/queries/dml.sql` file.

### 3. Update Database Credentials
Update the `DatabaseUtil.java` file with your MySQL credentials:
```java
private static final String URL = "jdbc:mysql://localhost:3306/sql_practice";
private static final String USER = "your_username";
private static final String PASSWORD = "your_password";
```

### 4. Build the Project
Use Maven to build the project:
```bash
mvn clean install
```

### 5. Run the Application
Run the Java classes to test SQL queries:
- **Advanced Joins**: `AdvancedSQLPractice.java`
- **Transactions**: `TransactionExample.java`

## SQL Concepts Covered

### Basics
- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`

### Joins
- Inner Join, Left Join, Self Join

### Grouping & Aggregation
- `GROUP BY`, `HAVING`

### Subqueries
- Nested queries in `SELECT`, `WHERE`, and `FROM`

### Transactions
- `BEGIN`, `COMMIT`, `ROLLBACK`

### Advanced Topics
- Window functions, CTEs, and more (extendable)

## Example Queries

### Inner Join with Filtering
```sql
SELECT e.name AS employee_name, d.name AS department_name, p.name AS project_name
FROM employees e
JOIN departments d ON e.dept_id = d.id
JOIN employee_projects ep ON e.id = ep.employee_id
JOIN projects p ON ep.project_id = p.id
WHERE d.name = 'IT';
```

### Transaction Example
```java
connection.setAutoCommit(false);
statement.executeUpdate("UPDATE employees SET salary = salary - 1000 WHERE id = 1");
statement.executeUpdate("UPDATE employees SET salary = salary + 1000 WHERE id = 2");
connection.commit();
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
```