import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;
import model.Doctor;
import model.Patient;
import dao.AppointmentDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AppointmentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
	@SuppressWarnings("unused")
	private AppointmentDAO appointmentDAO;

    public void init() {
        // Initialize the AppointmentDAO instance
        appointmentDAO = new AppointmentDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        List<Appointment> appointments = appointmentDAO.getAllAppointments();
        
        if (appointments == null) {
            appointments = new ArrayList<>(); 
        }
        
        request.setAttribute("appointments", appointments); // Set appointments as a request attribute
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
}
