import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Appointment;
import model.Doctor;
import dao.AppointmentDAO;
import dao.DoctorDAO;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class UpdateAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
	private AppointmentDAO appointmentDAO;
    @SuppressWarnings("unused")
	private DoctorDAO doctorDAO;
    public void init() {
        // Initialize the AppointmentDAO instance
        appointmentDAO = new AppointmentDAO();
        doctorDAO = new DoctorDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String appointmentDateStr = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");
        Integer doctorId = null;
        String doctorName = null;

        // Check if doctorId parameter exists
        String doctorIdParam = request.getParameter("doctorId");
        if (doctorIdParam != null && !doctorIdParam.isEmpty()) {
            doctorId = Integer.parseInt(doctorIdParam);
        }

        // Check if doctorName parameter exists
        doctorName = request.getParameter("doctorName");

        // Convert appointmentDateStr to Date object
        Date appointmentDate = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            appointmentDate = dateFormat.parse(appointmentDateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        AppointmentDAO appointmentDAO = new AppointmentDAO();
        Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);

        if (appointment != null) {
            // Update the appointment object with the new values
            appointment.setDate(appointmentDate);
            appointment.setTime(appointmentTime);
            Doctor doctor = new Doctor(doctorId, doctorName);
            doctor.setName(doctorName);
            appointment.setDoctor(doctor);

            // Call the updateAppointment method to update the appointment in the database
            appointmentDAO.updateAppointment(appointment);
        }

        response.sendRedirect("appointments.jsp");
    }


}
