import bookstack.DatabaseUtils;
import bookstack.User;
import bookstack.Book;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BookAcquisitionServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(("user"));
        String isbn = request.getParameter("isbn");
        Book book = null;
        
        // Get book
        try {
            book = DatabaseUtils.getBookFromISBN(isbn);
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }
        // Get book's price
        int price = book.getPrice();

        // Delete book submission from DB
        try {
            DatabaseUtils.deleteBookSubmission(isbn);
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }

        // Update user's credits
        try {
            DatabaseUtils.updateUserCredits(user.getId(), user.getCredits() - price);
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }

        // Increment user's books taken
        try {
            DatabaseUtils.updateUserBooksTaken(user.getBooksTaken() + 1, user.getId());
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }

        // Refresh User
        try {
            user = DatabaseUtils.getUserFromUsernameAndPassword(user.getEmail(), user.getPassword());
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }

        session.setAttribute("user", user);
        request.setAttribute("book_acquired", true);
        request.getRequestDispatcher("/account.jsp")
            .forward(request, response);
    }
}
