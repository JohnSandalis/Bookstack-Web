import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bookstack.DatabaseUtils;
import bookstack.User;

import org.apache.commons.lang3.StringUtils;

public class EditEntryServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Get all values from HTML Form
        String isbn = request.getParameter("isbn");
        String title = request.getParameter("title");
        String subtitle = request.getParameter("subtitle");
        int pageCount = Integer.parseInt(request.getParameter("page_count"));
        String thumbnailUrl = request.getParameter("thumbnail_url");
        String publisher = request.getParameter("publisher");
        String strDate = StringUtils.strip(request.getParameter("publish_date"));
        String lang = request.getParameter("language");
        List<String> authors = Arrays.asList(request.getParameterValues("authors"));
        List<String> subjects = Arrays.asList(request.getParameterValues("subjects"));

        // Build modifications string
        String modificationString = "";
        modificationString.concat("isbn=" + isbn + "&");
        modificationString.concat("title=" + title + "&");
        modificationString.concat("subtitle=" + subtitle + "&");
        modificationString.concat("pages_count=" + String.valueOf(pageCount) + "&");
        modificationString.concat("thumbnail_url=" + thumbnailUrl + "&");
        modificationString.concat("publisher=" + publisher + "&");
        modificationString.concat("publish_date=" + strDate + "&");
        modificationString.concat("lang=" + lang + "&");
        for (String author : authors) {
            modificationString.concat("authors=" + author + "&");
        }
        for (String subject : subjects) {
            modificationString.concat("subjects=" + subject + "&");
        }
        modificationString = StringUtils.chop(modificationString); // Remove '&' from string's end

        try {
            DatabaseUtils.addNewModificationRequest(user.getId(), isbn, modificationString);
        } catch (SQLException e) {
            throw new ServletException(e.getMessage());
        }

        session.setAttribute("modification_entry", true);
        response.sendRedirect(request.getContextPath() + "/account.jsp");
    }
}
