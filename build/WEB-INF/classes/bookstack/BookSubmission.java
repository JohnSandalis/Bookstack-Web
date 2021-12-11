package bookstack;

import java.util.Date;
/**
 * POJO of books_submitted table
 * 
 * @author Giorgos Lagoudakis
 * @version 1.0
 */
public class BookSubmission {

    private final String id;
    private final Date timeOf;
    private final int userId;
    private final Book book;

    public BookSubmission(String id, Date timeOf, int userId, Book book) {
        this.id = id;
        this.timeOf = timeOf;
        this.userId = userId;
        this.book = book;
    }

    public String getId() {
        return id;
    }

    public Date getTimeOf() {
        return timeOf;
    }

    public int getUserId() {
        return userId;
    }

    public Book getBook() {
        return book;
    }
}