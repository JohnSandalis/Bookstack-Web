import bookstack.DatabaseUtils;

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

public class AuthorServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String searchString = request.getParameter("name");
        List<String> authors = new ArrayList<String>();
        try {

            authors.addAll(DatabaseUtils.searchAuthorWithName(searchString));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        JSONArray jsonArray = new JSONArray();
        for (int count = 0; count < authors.size(); count++) {
            JSONObject item = new JSONObject();
            item.put("id", authors.get(count));
            item.put("text", authors.get(count));
            jsonArray.put(item);
            
        }
        
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("results", jsonArray);
        String json = jsonObject.toString();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = new PrintWriter(response.getWriter(), true);
        out.println(json);
    }
}
