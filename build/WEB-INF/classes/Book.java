/**
 * Public constructor Book
 * 
 * @author isandalis
 * @version 1.0
 */
public class Book {

    private String isbn;
    private String title;
    private String subtitle;
    private int page_count;
    private String thumbnail_url;
    private String publisher;
    private String publish_date;
    private String lang;

    public Book(String isbn, String title, String subtitle, int page_count, String thumbnail_url,
    String publisher, String publish_date, String lang) {
        this.isbn = isbn;
        this.title = title;
        this.subtitle = subtitle;
        this.page_count = page_count;
        this.thumbnail_url = thumbnail_url;
        this.publisher = publisher;
        this.publish_date = publish_date;
        this.lang = lang;
    }

    public String get_isbn() {
        return this.isbn;
    }
    
    public String get_title() {
        return this.title;
    }
    
    public String get_subtitle() {
        return this.subtitle;
    }
    
    public int get_page_count(){
        return this.page_count;
    }
    
    public String get_thumbnail_url() {
        return this.thumbnail_url;
    }
    
    public String get_publisher() {
        return this.publisher;
    }
    
    public String get_publish_date() {
        return this.publish_date;
    }
    
    public String get_lang() {
        return this.lang;
    }
}