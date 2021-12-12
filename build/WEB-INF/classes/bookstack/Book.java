package bookstack;

import java.util.Date;
import java.util.List;

/**
 * Public constructor Book
 * 
 * @author isandalis
 * @version 1.0
 */
public class Book {

    private final String isbn;
    private final String title;
    private final String subtitle;
    private final int pageCount;
    private final String thumbnailUrl;
    private final String publisher;
    private final Date publishDate;
    private final String lang;
    private final int price;
    private final List<String> authors;
    private final List<String> subjects;

    public Book(String isbn, String title, String subtitle, int pageCount, String thumbnailUrl, String publisher,
                Date publishDate, String lang, int price, List<String> authors, List<String> subjects) {
        this.isbn = isbn;
        this.title = title;
        this.subtitle = subtitle;
        this.pageCount = pageCount;
        this.thumbnailUrl = thumbnailUrl;
        this.publisher = publisher;
        this.publishDate = publishDate;
        this.lang = lang;
        this.price = price;
        this.authors = authors;
        this.subjects = subjects;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getTitle() {
        return title;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public int getPageCount() {
        return pageCount;
    }

    public String getThumbnailUrl() {
        return thumbnailUrl;
    }

    public String getPublisher() {
        return publisher;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public String getLang() {
        return lang;
    }

    public int getPrice() {
        return price;
    }

    public List<String> getAuthors() {
        return authors;
    }

    public List<String> getSubjects() {
        return subjects;
    }
}