import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Provides the utility fields and functions, regarding the Bookstack Database.
 * @author Giorgos Lagoudakis
 * @version 1.0
 */
public class DatabaseUtils {

    // Information used to build the Connection URL
    private static final String DATABASE_HOST = "195.251.249.131";
    private static final String DATABASE_SCHEMA_NAME = "ismgroup6";
    private static final String DATABASE_USERNAME = "ismgroup6";
    private static final String DATABASE_PASSWORD = "$9#9j#";
    private static final String DATABASE_PORT = "3306";

    // Queries used in methods below
    private static final String SELECT_SUBMITTED_BOOKS = "SELECT * FROM books_submitted";
    private static final String SELECT_BOOK_WITH_ISBN = "SELECT * FROM books WHERE isbn = '%s'";
    private static final String SELECT_AUTHORS_OF_BOOK = "SELECT * FROM authors WHERE isbn = '%s'";
    private static final String SELECT_BOOK_SUBJECTS = "SELECT * FROM books_subjects WHERE isbn = '%s'";
    private static final String SELECT_SUBJECT_FROM_ID = "SELECT * FROM subjects WHERE id = '%d'";
    private static final String SELECT_USER_FROM_EMAIL_AND_PASSWORD = "SELECT * FROM users WHERE" +
            "email = '%s' AND password = '%s'";
    private static final String SIGN_UP_USER = "INSERT INTO users VALUES(DEFAULT, '%s', '%s', 0, 0," +
            "'%s', '%s',  NULL, NULL, NULL, NULL, NULL, NULL, NULL";

    // Returns an active connection object to the project's database
    private static Connection createDatabaseConnection() throws SQLException {
        return DriverManager.getConnection(getConnectionURL());
    }

    // Builds the Connection URL to the project's database
    private static String getConnectionURL() {
        return String.format("jdbc:mysql://%s:%s/%s?user=%s&password=%s",
                DATABASE_HOST, DATABASE_PORT, DATABASE_SCHEMA_NAME, DATABASE_USERNAME, DATABASE_PASSWORD);
    }

    /**
     * Creates a connection to the database and gets the user submitted books
     * @return books that users submitted for trading
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<BookSubmission> getSubmittedBooks() throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            List<BookSubmission> bookSubmissions = new ArrayList<>();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(SELECT_SUBMITTED_BOOKS);
            while(rs.next()) {
                String id = rs.getString("id");
                Date time_of = rs.getDate("time_of");
                int user_id = rs.getInt("user_id");
                String book_isbn = rs.getString("book_isbn");
                Book book = getBookFromISBN(book_isbn);
                bookSubmissions.add(new BookSubmission(id, time_of, user_id, book));
            }
            return bookSubmissions;
        }
    }

    /**
     * Creates a connection to the database and gets the book with the corresponding ISBN
     * @param isbn The unique ISBN of the specific book
     * @return the book with it's details
     * @throws SQLException when a connection to the database cannot be established
     */
    public static Book getBookFromISBN(String isbn) throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(String.format(SELECT_BOOK_WITH_ISBN, isbn));
            if(rs.next()) {
                String title = rs.getString("title");
                String subtitle = rs.getString("subtitle");
                int pages_count = rs.getInt("pages_count");
                String thumbnail_url = rs.getString("thumbnail_url");
                String publisher = rs.getString("publisher");
                Date publish_date = rs.getDate("publish_date");
                String lang = rs.getString("lang");
                int price = rs.getInt("price");
                List<String> authors = getAuthorsOfBook(isbn);
                List<String> subjects = getBookSubjects(isbn);
                return new Book(isbn, title, subtitle, pages_count, thumbnail_url, publisher,
                        publish_date, lang, price, authors, subjects);
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and gets the authors of the book with the corresponding isbn
     * @param isbn The unique ISBN of the book that we want the authors of
     * @return the names of the authors
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<String> getAuthorsOfBook(String isbn) throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            List<String> authorNames = new ArrayList<>();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(String.format(SELECT_AUTHORS_OF_BOOK, isbn));
            while (rs.next()) {
                String name = rs.getString("name");
                authorNames.add(name);
            }
            return authorNames;
        }
    }

    /**
     * Creates a connection to the database and gets the subjects of the book with the corresponding isbn
     * @param isbn The unique ISBN of the book that we want the subjects of
     * @return the subjects of the book
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<String> getBookSubjects(String isbn) throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            List<String> bookSubjects = new ArrayList<>();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(String.format(SELECT_BOOK_SUBJECTS, isbn));
            while (rs.next()) {
                int id = rs.getInt("id");
                String subject = getSubjectFromId(id);
                bookSubjects.add(subject);
            }
            return bookSubjects;
        }
    }

    /**
     * Creates a connection to the database and gets the subject with the corresponding id
     * @param id the id of the subjects table
     * @return the subject of the corresponding id
     * @throws SQLException when a connection to the database cannot be established
     */
    public static String getSubjectFromId(int id) throws  SQLException {
        try(Connection connection = createDatabaseConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(String.format(SELECT_SUBJECT_FROM_ID, id));
            if (rs.next()) {
                return rs.getString("name");
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and gets the user with the corresponding username and password
     * @param email The email of the user
     * @param password The password of the user
     * @return a User object that contains all the user details
     * @throws SQLException when a connection to the database cannot be established
     */
    public static User getUserFromUsernameAndPassword(String email, String password) throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(String.format(SELECT_USER_FROM_EMAIL_AND_PASSWORD, email, password));
            if (rs.next()) {
                int id = rs.getInt("id");
                int credits = rs.getInt("credits");
                int booksGiven = rs.getInt("books_given");
                int booksTaken = rs.getInt("booksTaken");
                String username = rs.getString("username");
                String fullName = rs.getString("full_name");
                String address = rs.getString("address");
                String country = rs.getString("country");
                String postalCode = rs.getString("postal_code");
                int atFloor = rs.getInt("at_floor");
                String region = rs.getString("region");
                String city = rs.getString("city");
                String lang = rs.getString("lang");
                return new User(id, email, password, credits, booksGiven, booksTaken, username, fullName, address,
                        country, postalCode, atFloor, region, city, lang);
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and inserts a new user record
     * @param firstName The first name of the user who's signing up
     * @param lastName The last name of the user who's signing up
     * @param username The username of the user who's signing up
     * @param email The email of the user who's signing up
     * @param password The password of the user who's signing up
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void createNewUser(String firstName, String lastName, String username,
                                     String email, String password) throws SQLException {
        try(Connection connection = createDatabaseConnection()) {
            Statement statement = connection.createStatement();
            String fullName = firstName + " " + lastName;
            statement.executeUpdate(String.format(SIGN_UP_USER, email, password, username, fullName));
        }
    }
}