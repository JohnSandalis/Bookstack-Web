import bookstack.DatabaseUtils;
import bookstack.Book;

import java.util.List;
import java.util.ArrayList;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

public class AvailableBookServlet extends HttpServlet {
    
    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Book> books = new ArrayList<Book>();
        try {
            books = DatabaseUtils.getBooks();    
        } catch (SQLException e) {
            e.printStackTrace();
        }

        JSONArray jsonArray = new JSONArray();
        for (Book book : books) {
            JSONObject item = new JSONObject();
            item.put("isbn", book.getIsbn());
            item.put("title", book.getTitle());
            item.put("subtitle", book.getSubtitle());
            item.put("pageCount", book.getPageCount());
            item.put("thumbnailUrl", book.getThumbnailUrl());
            item.put("publisher", book.getPublisher());
            item.put("publishDate", book.getPublishDate().toString());
            item.put("lang", book.getLang());
            item.put("price", book.getPrice());
            JSONArray authors = new JSONArray(book.getAuthors());
            item.put("authors", authors);
            JSONArray subjects = new JSONArray(book.getSubjects());
            item.put("subjects", subjects);
            jsonArray.put(item);
        }
        String json = jsonArray.toString();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = new PrintWriter(response.getWriter(), true);
        out.println(json);

    }
}
