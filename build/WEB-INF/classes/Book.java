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
    private final int page_count;
    private final String thumbnail_url;
    private final String publisher;
    private final Date publish_date;
    private final String lang;
    private final int price;
    private final List<String> authors;
    private final List<String> subjects;

    public Book(String isbn, String title, String subtitle, int page_count, String thumbnail_url, String publisher,
                Date publish_date, String lang, int price, List<String> authors, List<String> subjects) {
        this.isbn = isbn;
        this.title = title;
        this.subtitle = subtitle;
        this.page_count = page_count;
        this.thumbnail_url = thumbnail_url;
        this.publisher = publisher;
        this.publish_date = publish_date;
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

    public int getPage_count() {
        return page_count;
    }

    public String getThumbnail_url() {
        return thumbnail_url;
    }

    public String getPublisher() {
        return publisher;
    }

    public Date getPublish_date() {
        return publish_date;
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