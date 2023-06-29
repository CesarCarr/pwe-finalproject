import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.HealthWorkerDAO;
import model.HealthWorker;
import utils.PasswordUtils;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Encrypt the entered password using a secure encryption algorithm
        String encryptedPassword = PasswordUtils.encryptPassword(password);

        // Query the database to fetch the stored username and encrypted password for the admin
        HealthWorkerDAO healthWorkerDAO = new HealthWorkerDAO();
        HealthWorker admin = healthWorkerDAO.getAdminByUsername(username);

        if (admin != null && admin.getPassword().equals(encryptedPassword)) {
            // Credentials match, create a session for the logged-in admin user
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);

            // Redirect to the index page
            response.sendRedirect("index.jsp");
        } else {
            // Credentials do not match, display an error message on the login page
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
