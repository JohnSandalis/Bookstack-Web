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

public class SubmitResidenceServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Get parameter values
        HttpSession session = request.getSession(true);
        User user = (User) session.getAttribute("user");
        String address = request.getParameter("address");
        int atFloor = Integer.parseInt(request.getParameter("floor"));
        String city = request.getParameter("city");
        String region = request.getParameter("region");
        String postalCode = request.getParameter("postal_code");
        String phoneNumber = request.getParameter("phone_number");
        String country = request.getParameter("country");
        String lang = country;

        // Assign values to user object
        try {
            DatabaseUtils.updateUserInfo(address, country, postalCode, atFloor,
                    region, city, lang, phoneNumber, user.getId());
            user = DatabaseUtils.getUserFromUsernameAndPassword(user.getEmail(), user.getPassword());
            session.setAttribute("user", user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Forward
        response.sendRedirect(request.getContextPath() + "/account.jsp");
    }
}
