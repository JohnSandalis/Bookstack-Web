import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookstack.Book;
import bookstack.DatabaseUtils;
import bookstack.User;

import org.apache.commons.lang3.StringUtils;

public class bookFormController extends HttpServlet {

    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Book book = null;
        try {
            book = DatabaseUtils.getBookFromISBN(isbn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (book == null) {
            String title = request.getParameter("title");
            String subtitle = request.getParameter("subtitle");
            int pageCount = Integer.parseInt(request.getParameter("page_count"));
            String thumbnailUrl = request.getParameter("thumbnail_url");
            if (StringUtils.isBlank(thumbnailUrl)) {
                thumbnailUrl = "#";
            }
            String publisher = request.getParameter("publisher");
            String strDate = StringUtils.strip(request.getParameter("publish_date"));
            Date publishDate = null;
            try {
                publishDate = DATE_FORMAT.parse(strDate);
            } catch (Exception e) {
                e.printStackTrace();
            }
            String lang = request.getParameter("language");
            List<String> authors = Arrays.asList(request.getParameterValues("authors"));
            List<String> subjects = Arrays.asList(request.getParameterValues("subjects"));

            // Create new book entry
            try {
                DatabaseUtils.createNewBook(isbn, title, subtitle, pageCount, 
                                        thumbnailUrl, publisher, publishDate, 
                                        lang, 0, authors, subjects);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Add book to user's submitted books
        Date currentDate = new Date();
        try {
            DatabaseUtils.addBooksSubmitted(currentDate, user.getId(), isbn);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Update the books given by the user
        try {
            DatabaseUtils.updateUserBooksGiven(user.getBooksGiven() + 1, user.getId());
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Refresh User
        try {
            user = DatabaseUtils.getUserFromUsernameAndPassword(user.getEmail(), user.getPassword());
        } catch (Exception e) {
            e.printStackTrace();
        }

        session.setAttribute("user", user);
        response.sendRedirect(request.getContextPath() + "/account.jsp");
    }
    
}
