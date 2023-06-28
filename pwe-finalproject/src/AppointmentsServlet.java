import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;
import model.Doctor;
import model.Patient;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class AppointmentsServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Appointment> appointments = fetchAppointmentsFromDatabase();
        request.setAttribute("appointments", appointments);
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }

    @SuppressWarnings("deprecation")
	private List<Appointment> fetchAppointmentsFromDatabase() {
        List<Appointment> appointments = new ArrayList<>();

        appointments.add(new Appointment(
                new Patient(123, "John Doe", new Date(85, 0, 15), 38, 175.5, 68.2, "A+"),
                new Doctor(0, "Dr. Smith"),
                new Date(),
                "10:00 AM"
        ));

        appointments.add(new Appointment(
                new Patient(456, "Jane Smith", new Date(92, 2, 27), 31, 163.8, 55.1, "B-"),
                new Doctor(0, "Dr. Johnson"),
                new Date(),
                "2:30 PM"
        ));

        return appointments;
    }
}
