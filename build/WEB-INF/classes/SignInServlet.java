import bookstack.DatabaseUtils;
import bookstack.User;

import java.util.List;
import java.util.ArrayList;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletResponse;

public class SignInServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String destination = (String) request.getAttribute("destination");
        HttpSession session = request.getSession(true);
        try {
            User user = DatabaseUtils.getUserFromUsernameAndPassword(email, password);
            if (user == null) {
                String alertText = "Wrong email or password. User does not exist.";
                request.setAttribute("alertText", alertText);
                destination = "signin.jsp";
            } else {
                session.setAttribute("user", user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (destination == null) {
            destination = "index.jsp";
        }
        destination = "/" + destination;
        response.sendRedirect(request.getContextPath() + destination);
    }
}