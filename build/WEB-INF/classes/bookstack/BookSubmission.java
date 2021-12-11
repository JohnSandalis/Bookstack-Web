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
    private final Date time_of;
    private final int user_id;
    private final Book book;

    public BookSubmission(String id, Date time_of, int user_id, Book book) {
        this.id = id;
        this.time_of = time_of;
        this.user_id = user_id;
        this.book = book;
    }

    public String getId() {
        return id;
    }

    public Date getTime_of() {
        return time_of;
    }

    public int getUser_id() {
        return user_id;
    }

    public Book getBook() {
        return book;
    }
}