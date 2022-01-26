package bookstack;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;

/**
 * Provides the utility fields and functions, regarding the Bookstack Database.
 * 
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
    private static final String SELECT_AVAILABLE_BOOKS = "SELECT * FROM books b WHERE b.isbn IN (SELECT DISTINCT " +
            "bs.book_isbn FROM books_submitted bs)";
    private static final String SELECT_USER_SUBMITTED_BOOKS = "SELECT * FROM books_submitted WHERE user_id = ?";
    private static final String SELECT_BOOK_WITH_ISBN = "SELECT * FROM books WHERE isbn = ?";
    private static final String SELECT_AUTHORS_OF_BOOK = "SELECT a.name FROM authors a, books_authors ba WHERE " +
            "ba.author_id = a.id AND ba.book_isbn = ?";
    private static final String SEARCH_AUTHOR_WITH_NAME = "SELECT name FROM authors WHERE name LIKE ?";
    private static final String SELECT_BOOK_SUBJECTS = "SELECT * FROM books_subjects WHERE isbn = ?";
    private static final String SELECT_SUBJECT_FROM_ID = "SELECT * FROM subjects WHERE id = ?";
    private static final String SELECT_USER_FROM_EMAIL_AND_PASSWORD = "SELECT * FROM users " +
            "WHERE email = ? AND pass = ?";
    private static final String SEARCH_SUBJECT_WITH_NAME = "SELECT name FROM subjects WHERE name LIKE ?";
    private static final String SELECT_SUBJECT_ID_FROM_SUBJECT = "SELECT id FROM subjects WHERE name = ?";
    private static final String SELECT_AUTHOR_ID_FROM_NAME = "SELECT id FROM authors WHERE name = ?";
    private static final String SIGN_UP_USER = "INSERT INTO users VALUES(DEFAULT, ?, ?, 0, 0, 0," +
            "?, ?,  NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)";
    private static final String CREATE_NEW_BOOK = "INSERT INTO books VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String CREATE_NEW_AUTHOR = "INSERT INTO authors VALUES(DEFAULT, ?)";
    private static final String CREATE_NEW_BOOK_AUTHOR = "INSERT INTO books_authors VALUES(?, ?)";
    private static final String CREATE_NEW_BOOK_SUBJECTS = "INSERT INTO books_subjects VALUES(?, ?)";
    private static final String CREATE_NEW_BOOK_SUBMITTED = "INSERT INTO books_submitted VALUES(DEFAULT, ?, ?, ?)";
    private static final String CREATE_NEW_SUBJECT = "INSERT INTO subjects VALUES(DEFAULT, ?)";
    private static final String CREATE_MODIFICATION_REQUEST = "INSERT INTO modification_requests VALUES(DEFAULT, ?, " +
            "?, ?)";
    private static final String UPDATE_USER_INFO = "UPDATE users SET address = ?, country = ?, " +
            "postal_code = ?, at_floor = ?, region = ?, city = ?, lang = ?, phone_number = ? WHERE id = ?";
    private static final String UPDATE_USER_BOOKS_GIVEN = "UPDATE users SET books_given = ? WHERE id = ?";
    private static final String UPDATE_USER_CREDITS = "UPDATE users SET credits = ? WHERE id = ?";

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
     * 
     * @return books that users submitted for trading
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<BookSubmission> getSubmittedBooks() throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            List<BookSubmission> bookSubmissions = new ArrayList<>();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(SELECT_SUBMITTED_BOOKS);
            while (rs.next()) {
                String id = rs.getString("id");
                Date time_of = rs.getTimestamp("time_of");
                int user_id = rs.getInt("user_id");
                String book_isbn = rs.getString("book_isbn");
                Book book = getBookFromISBN(book_isbn);
                bookSubmissions.add(new BookSubmission(id, time_of, user_id, book));
            }
            return bookSubmissions;
        }
    }

    /**
     * Creates a connection to the database and gets info on all available books
     * 
     * @return books available
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<Book> getBooks() throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            List<Book> books = new ArrayList<>();
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery(SELECT_AVAILABLE_BOOKS);
            while (rs.next()) {
                String isbn = rs.getString("isbn");
                String title = rs.getString("title");
                String subtitle = rs.getString("subtitle");
                int pageCount = rs.getInt("pages_count");
                String thumbnailUrl = rs.getString("thumbnail_url");
                String publisher = rs.getString("publisher");
                Date publishDate = rs.getDate("publish_date");
                String lang = rs.getString("lang");
                int price = rs.getInt("price");
                List<String> authors = getAuthorsOfBook(isbn);
                List<String> subjects = getBookSubjects(isbn);
                Book book = new Book(isbn, title, subtitle, pageCount, thumbnailUrl, publisher,
                        publishDate, lang, price, authors, subjects);
                books.add(book);
            }
            return books;
        }
    }

    /**
     * Creates a connection to the database and gets the user's submitted books
     * 
     * @param user_id The unique ID of the specific user
     * @return books that a specific user has submitted for trading
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<BookSubmission> getUserSubmittedBooks(int user_id) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            List<BookSubmission> userBookSubmissions = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement(SELECT_USER_SUBMITTED_BOOKS);
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String id = rs.getString("id");
                Date time_of = rs.getTimestamp("time_of");
                String book_isbn = rs.getString("book_isbn");
                Book book = getBookFromISBN(book_isbn);
                userBookSubmissions.add(new BookSubmission(id, time_of, user_id, book));
            }
            return userBookSubmissions;
        }
    }

    /**
     * Creates a connection to the database and gets the book with the corresponding
     * ISBN
     * 
     * @param isbn The unique ISBN of the specific book
     * @return the book with it's details
     * @throws SQLException when a connection to the database cannot be established
     */
    public static Book getBookFromISBN(String isbn) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_BOOK_WITH_ISBN);
            ps.setString(1, isbn);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
     * Creates a connection to the database and gets the authors of the book with
     * the corresponding isbn
     * 
     * @param isbn The unique ISBN of the book that we want the authors of
     * @return the names of the authors
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<String> getAuthorsOfBook(String isbn) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            List<String> authorNames = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement(SELECT_AUTHORS_OF_BOOK);
            ps.setString(1, isbn);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                authorNames.add(name);
            }
            return authorNames;
        }
    }

    /**
     * Creates a connection to the database and gets the subjects of the book with
     * the corresponding isbn
     * 
     * @param isbn The unique ISBN of the book that we want the subjects of
     * @return the subjects of the book
     * @throws SQLException when a connection to the database cannot be established
     */
    public static List<String> getBookSubjects(String isbn) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            List<String> bookSubjects = new ArrayList<>();
            PreparedStatement ps = connection.prepareStatement(SELECT_BOOK_SUBJECTS);
            ps.setString(1, isbn);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                String subject = getSubjectFromId(id);
                bookSubjects.add(subject);
            }
            return bookSubjects;
        }
    }

    /**
     * Creates a connection to the database and gets the subject with the
     * corresponding id
     * 
     * @param id the id of the subjects table
     * @return the subject of the corresponding id
     * @throws SQLException when a connection to the database cannot be established
     */
    public static String getSubjectFromId(int id) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_SUBJECT_FROM_ID);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and gets author's id by their name
     * 
     * @param name author's name
     * @return int author's id
     * @throws SQLException
     */
    public static Integer getAuthorIdFromName(String name) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_AUTHOR_ID_FROM_NAME);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and gets the user with the corresponding
     * username and password
     * 
     * @param email    The email of the user
     * @param password The password of the user
     * @return a User object that contains all the user details
     * @throws SQLException when a connection to the database cannot be established
     */
    public static User getUserFromUsernameAndPassword(String email, String password) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_USER_FROM_EMAIL_AND_PASSWORD);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("id");
                int credits = rs.getInt("credits");
                int booksGiven = rs.getInt("books_given");
                int booksTaken = rs.getInt("books_taken");
                String username = rs.getString("username");
                String fullName = rs.getString("full_name");
                String address = rs.getString("address");
                String country = rs.getString("country");
                String postalCode = rs.getString("postal_code");
                int atFloor = rs.getInt("at_floor");
                String region = rs.getString("region");
                String city = rs.getString("city");
                String lang = rs.getString("lang");
                String phoneNumber = rs.getString("phone_number");
                return new User(id, email, password, credits, booksGiven, booksTaken, username, fullName, address,
                        country, postalCode, atFloor, region, city, lang, phoneNumber);
            }
            return null;
        }
    }

    /**
     * Creates a connection to the database and retrieves the ids of the subjects
     * 
     * @param subjects The subjects of the book
     * @return The ids of the subjects in the subjects table
     * @throws SQLException when a connection to the database cannot be established
     */
    public static Integer getSubjectIdFromSubject(String subject) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_SUBJECT_ID_FROM_SUBJECT);
            ps.setString(1, subject);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            return null;
        }
    }

    /**
     * Returns true if the subject already exists in the subjects table
     * 
     * @param name The name of the subject
     * @return true if the subject already exists, false otherwise
     * @throws SQLException when a connection to the database cannot be established
     */
    public static boolean subjectAlreadyExists(String name) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SELECT_SUBJECT_FROM_ID);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        }
    }

    /**
     * Creates a connection to the database and returns all subjects, the names of
     * which
     * resemble the given string
     * 
     * @param str String to search resembling names
     * @return The names of the subjects
     * @throws SQLException
     */
    public static List<String> searchSubjectWithName(String str) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SEARCH_SUBJECT_WITH_NAME);
            String strWildcards = "%" + str + "%";
            ps.setString(1, strWildcards);
            ResultSet rs = ps.executeQuery();
            List<String> subjectNames = new ArrayList<>();
            while (rs.next()) {
                String subject = rs.getString("name");
                subjectNames.add(subject);
            }
            return subjectNames;
        }
    }

    /**
     * Creates a connection to the database and returns all authors, the names of
     * which
     * resemble the given string
     * 
     * @param str String to search resembling names
     * @return The names of the authors
     * @throws SQLException
     */
    public static List<String> searchAuthorWithName(String str) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SEARCH_AUTHOR_WITH_NAME);
            String strWildcards = "%" + str + "%";
            ps.setString(1, strWildcards);
            ResultSet rs = ps.executeQuery();
            List<String> authorNames = new ArrayList<>();
            while (rs.next()) {
                String author = rs.getString("name");
                authorNames.add(author);
            }
            return authorNames;
        }
    }

    /**
     * Creates a connection to the database and inserts a new user record
     * 
     * @param firstName The first name of the user who's signing up
     * @param lastName  The last name of the user who's signing up
     * @param username  The username of the user who's signing up
     * @param email     The email of the user who's signing up
     * @param password  The password of the user who's signing up
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void createNewUser(String firstName, String lastName, String username,
            String email, String password) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(SIGN_UP_USER);
            String fullName = firstName + " " + lastName;
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, username);
            ps.setString(4, fullName);
            ps.executeUpdate();
        }
    }

    /**
     * Creates a connection to the database and inserts a new book
     * 
     * @param isbn         The isbn of the book
     * @param title        The title of the book
     * @param subtitle     The subtitle of the book
     * @param pagesCount   The pages count of the book
     * @param thumbnailUrl A url of the cover of the book
     * @param publisher    The publisher of the book
     * @param publishDate  The publish date of the book
     * @param lang         The language that the book is written in
     * @param price        The price of the book as credits
     * @param authors      The authors of the book
     * @param subjects     The subjects of the book
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void createNewBook(String isbn, String title, String subtitle, int pagesCount, String thumbnailUrl,
            String publisher, Date publishDate, String lang, int price, List<String> authors,
            List<String> subjects) throws SQLException {

        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(CREATE_NEW_BOOK);
            ps.setString(1, isbn);
            ps.setString(2, title);
            ps.setString(3, subtitle);
            ps.setInt(4, pagesCount);
            ps.setString(5, thumbnailUrl);
            ps.setString(6, publisher);
            ps.setDate(7, new java.sql.Date(publishDate.getTime()));
            ps.setString(8, lang);
            ps.setInt(9, price);
            ps.executeUpdate();

            List<String> createAuthors = new ArrayList<>();
            for (String authorName : authors) {
                List<String> foundAuthors = searchAuthorWithName(authorName);
                if (foundAuthors.isEmpty() || !foundAuthors.contains(authorName)) {
                    createAuthors.add(authorName);
                }
            }
            if (!createAuthors.isEmpty()) {
                createNewAuthors(createAuthors);
            }
            addBookAuthors(isbn, authors);

            List<String> createSubjects = new ArrayList<>();
            for (String subjectName : subjects) {
                if (getSubjectIdFromSubject(subjectName) == null) {
                    createSubjects.add(subjectName);
                }
            }

            if (!createSubjects.isEmpty()) {
                createNewSubjects(createSubjects);
            }
            addBookSubjects(isbn, subjects);
        }
    }

    /**
     * Creates a connection to the database and inserts the authors
     * 
     * @param names The names of the authors
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void createNewAuthors(List<String> names) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            for (String name : names) {
                PreparedStatement ps = connection.prepareStatement(CREATE_NEW_AUTHOR);
                ps.setString(1, name);
                ps.executeUpdate();
            }
        }
    }

    /**
     * Creates a connection to the database and adds a new subject to the subjects
     * table
     * 
     * @param name The name of the subject
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void createNewSubjects(List<String> subjects) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            for (String subject : subjects) {
                PreparedStatement ps = connection.prepareStatement(CREATE_NEW_SUBJECT);
                ps.setString(1, subject);
                ps.executeUpdate();
            }
        }
    }

    /**
     * Creates a connection to the database and adds id(s) and isbn to books_authors
     * table
     * 
     * @param isbn    book isbn
     * @param authors List with author name(s), with which id will be found
     * @throws SQLException
     */
    public static void addBookAuthors(String isbn, List<String> authors) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            for (String authorName : authors) {
                int id = getAuthorIdFromName(authorName);
                PreparedStatement ps = connection.prepareStatement(CREATE_NEW_BOOK_AUTHOR);
                ps.setInt(1, id);
                ps.setString(2, isbn);
                ps.executeUpdate();
            }
        }
    }

    /**
     * Creates a connection to the database and adds the ids to the books_subjects
     * table
     * 
     * @param isbn     The isbn of the book that we're addng the subjects
     * @param subjects The subjects of the book
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void addBookSubjects(String isbn, List<String> subjects) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            for (String subject : subjects) {
                int id = getSubjectIdFromSubject(subject);
                PreparedStatement ps = connection.prepareStatement(CREATE_NEW_BOOK_SUBJECTS);
                ps.setString(1, isbn);
                ps.setInt(2, id);
                ps.executeUpdate();
            }
        }
    }

    /**
     * Creates a connection to the database and adds a book submission to the
     * books_submitted table
     * 
     * @param timeOf The time of the book submission
     * @param userId The id of the user
     * @param isbn   The book isbn
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void addBooksSubmitted(Date timeOf, int userId, String isbn) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(CREATE_NEW_BOOK_SUBMITTED);
            ps.setTimestamp(1, new java.sql.Timestamp(timeOf.getTime()));
            ps.setInt(2, userId);
            ps.setString(3, isbn);
            ps.executeUpdate();
        }
    }

    /**
     * Creates a connection to the database and adds a new modification request to
     * the modifications_requests table
     * 
     * @param userId        The id of the user creating the modification
     * @param bookIsbn      The isbn of the book being modified
     * @param modifications The modifications being made to the book
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void addNewModificationRequest(int userId, String bookIsbn,
            String modifications) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(CREATE_MODIFICATION_REQUEST);
            ps.setInt(1, userId);
            ps.setString(2, bookIsbn);
            ps.setString(3, modifications);
            ps.executeUpdate();
        }
    }

    /**
     * Creates a connection to the database and updates the user's - with the
     * specific id - details
     * 
     * @param address    The new user's address
     * @param country    The new user's country
     * @param postalCode The new user's postal code
     * @param atFloor    The new user's floor
     * @param region     The new user's region
     * @param city       The new user's city
     * @param lang       The new user's lang
     * @param id         The user's id when a connection to the database cannot be
     *                   established
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void updateUserInfo(String address, String country, String postalCode, int atFloor,
            String region, String city, String lang, String phoneNumber, int id) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(UPDATE_USER_INFO);
            ps.setString(1, address);
            ps.setString(2, country);
            ps.setString(3, postalCode);
            ps.setInt(4, atFloor);
            ps.setString(5, region);
            ps.setString(6, city);
            ps.setString(7, lang);
            ps.setString(8, phoneNumber);
            ps.setInt(9, id);
            ps.executeUpdate();
        }
    }

    /**
     * Creasts a connection to the database and updates the user's - with the
     * specific id - books_given
     * 
     * @param id         The id of the user
     * @param booksGiven The new number of books given by the user
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void updateUserBooksGiven(int booksGiven, int id) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(UPDATE_USER_BOOKS_GIVEN);
            ps.setInt(1, booksGiven);
            ps.setInt(2, id);
        }
    }

    /**
     * Creasts a connection to the database and updates the user's - with the
     * specific id - credits
     * 
     * @param id         The id of the user
     * @param newCredits The new amount of credits
     * @throws SQLException when a connection to the database cannot be established
     */
    public static void updateUserCredits(int id, int newCredits) throws SQLException {
        try (Connection connection = createDatabaseConnection()) {
            PreparedStatement ps = connection.prepareStatement(UPDATE_USER_CREDITS);
            ps.setInt(1, newCredits);
            ps.setInt(2, id);
            ps.executeUpdate();
        }
    }

}