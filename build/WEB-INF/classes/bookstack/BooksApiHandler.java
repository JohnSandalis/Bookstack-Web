package bookstack;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;
import org.json.JSONArray;

public class BooksApiHandler {

    /** Formatter for creating Date objects, by parsing API's dates */
    private static final SimpleDateFormat DATE_FORMATTER = new SimpleDateFormat("yyyy-MM-dd");

    /** Google Books API endpoint */
    private static final String API_ENDPOINT = "https://www.googleapis.com/books/v1/volumes?";

    /**
     * Sends a search query to the Google Books API, so as to fetch information of a book,
     * given its ISBN.
     * 
     * @param isbn              a numeric String which represents a book's ISBN code
     * @return                  the book which corresponds to the given ISBN, or null
     * @throws IOException
     * @throws JSONException
     * @see                     Book
     */
    public static Book searchByIsbn(String isbn) throws IOException, JSONException {
        String query = "q=isbn:" + isbn;
        String url = API_ENDPOINT + query;

        try {
            JSONObject json = readJsonFromUrl(url);
            JSONArray items = json.getJSONArray("items");
            JSONObject root = items.getJSONObject(0);
            JSONObject volumeInfo = root.getJSONObject("volumeInfo");

            // Fetch title from json
            String title = volumeInfo.optString("title");
            // Fetch subtitle from json
            String subtitle = volumeInfo.optString("subtitle");
            // Fetch page count from json
            int pageCount = volumeInfo.optInt("pageCount");
            // Fetch publisher from json
            String publisher = volumeInfo.optString("publisher");
            // Fetch publish date from json
            String dateString = volumeInfo.optString("publishedDate");
            Date publishDate;
            try {    
                // Create Date object from publishDate string
                publishDate = DATE_FORMATTER.parse(dateString);
            } catch (Exception e) {
                publishDate = null;
            }
            // Fetch language from json
            String lang = volumeInfo.optString("language");
            // Fetch thumbnail url from json
            JSONObject image_links = volumeInfo.optJSONObject("imageLinks");
            String thumbnailUrl = null;
            if (image_links != null) {
                thumbnailUrl = image_links.optString("thumbnail");
            }
            // Fetch authors name from json
            JSONArray authors_arr = volumeInfo.optJSONArray("authors");
            List<String> authors = new ArrayList<String>();
            if (authors_arr != null) {
                for (int i = 0; i < authors_arr.length(); i++) {
                    authors.add(authors_arr.optString(i));
                }
            }   
            // Fetch subjects from json
            JSONArray subjects_arr = volumeInfo.optJSONArray("categories");
            List<String> subjects = new ArrayList<String>();
            if (subjects_arr != null) {
                for (int i = 0; i < subjects_arr.length(); i++) {
                    subjects.add(subjects_arr.optString(i));
                }
            }

            int price = 0;
            // Return book object
            Book book = new Book(isbn, title, subtitle, pageCount, thumbnailUrl,
                    publisher, publishDate, lang, price, authors, subjects);
            return book;
        } catch (IOException | JSONException e) {
            return null;
        }
    }

    /**
     * Connects to given URL and reads JSON, in order to create a JSONObject
     * 
     * @param url url to connect and get JSON
     * @return    the JSON response from the URL
     * @throws IOException
     * @throws JSONException
     */
    public static JSONObject readJsonFromUrl(String url) throws IOException, JSONException {
        InputStream inputStream = new URL(url).openStream(); // TODO Handle connection errors
        try {
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, Charset.forName("UTF-8")));
            JSONTokener tokener = new JSONTokener(reader);
            JSONObject json = new JSONObject(tokener);
            return json;
        } finally {
            inputStream.close();
        }
    }

}