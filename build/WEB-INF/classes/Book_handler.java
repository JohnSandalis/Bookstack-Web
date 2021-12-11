import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONArray;

public class Book_handler {

    private static List<String> authors = new ArrayList<>();
    private static SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");

    public static Book search_by_isbn(String isbn) throws IOException, JSONException {
        String api_request = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn;
        String title = null;
        String subtitle = null;
        int page_count = 0;
        String thumbnail_url = null;
        String publisher = null;
        Date publish_date = null;
        String lang = null;
        try{
            JSONObject json = readJsonFromUrl(api_request);
            JSONArray items = json.getJSONArray("items");
            JSONObject root = items.getJSONObject(0);
            JSONObject volumeInfo = root.getJSONObject("volumeInfo");
            // Fetch title from json
            try {
                title = volumeInfo.getString("title");
            } catch(Exception e) {}
            // Fetch subtitle from json
            try {
                subtitle = volumeInfo.getString("subtitle");
            } catch(Exception e) {}
            // Fetch page count from json
            try {
                page_count = volumeInfo.getInt("pageCount");
            } catch(Exception e) {}
            // Fetch publisher from json
            try {
                publisher = volumeInfo.getString("publisher");
            } catch(Exception e) {}
            // Fetch publish date from json
            try {
                String dateString = volumeInfo.getString("publishedDate");
                // Create Date object from publish_date string
                publish_date = dateFormatter.parse(dateString);
            } catch(Exception e) {}
            // Fetch language from json
            try{
                lang = volumeInfo.getString("language");
            } catch(Exception e) {}
            // Fetch thumbnail url from json
            try {
                JSONObject image_links = volumeInfo.getJSONObject("imageLinks");
                thumbnail_url = image_links.getString("thumbnail");
            } catch(Exception e) {}
            // Fetch authors name from json
            try {
                JSONArray authors_arr = volumeInfo.getJSONArray("authors");
                for (int i = 0; i < authors_arr.length(); i++) {
                    authors.add(authors_arr.getString(i));
                }
            } catch(Exception e) {}
            // Return book object
            Book book = new Book(isbn, title, subtitle, page_count, thumbnail_url,
             publisher, publish_date, lang);
            return book;
        } catch(IOException | JSONException e) {
            return null;
        }
    }

    public static void main(String[] args) throws IOException {
        String isbn = "9780984358168";
        Book book = search_by_isbn(isbn);
        if (book != null) {
            System.out.println("ISBN: " + book.getIsbn());
            System.out.println("Title: " + book.getTitle());
            System.out.println("Subtitle: " + book.getSubtitle());
            System.out.println("Page Count: " + book.getPage_count());
            System.out.println("Thumbnail url: " + book.getThumbnail_url());
            System.out.println("Publisher: " + book.getPublisher());
            System.out.println("Publish Date: " + book.getPublish_date());
            System.out.println("Language: " + book.getLang());
            System.out.print("Authors name: ");
            for (int i = 0; i < authors.size(); i++) {
                if (i == authors.size() - 1) {
                    System.out.println(authors.get(i));
                } else {
                    System.out.print(authors.get(i) + ", ");
                }
            }
            
        } else {
            System.out.println("Please make a new entry");
        }
    }

    private static String readAll(Reader rd) throws IOException {
        StringBuilder sb = new StringBuilder();
        int cp;
        while ((cp = rd.read()) != -1) {
        sb.append((char) cp);
        }
        return sb.toString();
    }

    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream is = new URL(url).openStream();
        try {
            BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
            String jsonText = readAll(rd);
            JSONObject json = new JSONObject(jsonText);
            return json;
        } finally {
            is.close();
        }
    }

}