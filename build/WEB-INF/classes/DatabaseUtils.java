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
                List<String> authors = getAuthorsOfBook(isbn);
                return new Book(isbn, title, subtitle, pages_count, thumbnail_url, publisher,
                        publish_date, lang, authors);
            }
            return null;
        }
    }

    /**
     *
     * @param isbn The unique ISBN of the book's authors that we're looking for
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
}