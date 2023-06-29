import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.AppointmentDAO;
import dao.DoctorDAO;
import dao.PatientDAO;
import model.Appointment;
import model.Doctor;
import model.Patient;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@SuppressWarnings("unused")
public class CreateAppointmentServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PatientDAO patientDAO;
    private DoctorDAO doctorDAO;
    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        patientDAO = new PatientDAO();
        doctorDAO = new DoctorDAO();
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Patient> patients = patientDAO.getAllPatients();
        List<Doctor> doctors = doctorDAO.getAllDoctors();

        // Set the attributes in the request scope
        request.setAttribute("patients", patients);
        request.setAttribute("doctors", doctors);

        // Forward the request to the create appointment JSP
        request.getRequestDispatcher("create_appointment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        int patientId = Integer.parseInt(request.getParameter("patient"));
        int doctorId = Integer.parseInt(request.getParameter("doctor"));
        String appointmentDate = request.getParameter("appointmentDate");
        String appointmentTime = request.getParameter("appointmentTime");

        Date date = null;
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            date = dateFormat.parse(appointmentDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Patient patient = patientDAO.getPatientById(patientId);
        Doctor doctor = doctorDAO.getDoctorById(doctorId);

        Appointment appointment = new Appointment(0, patient, doctor, date, appointmentTime);

        appointmentDAO.createAppointment(appointment);

        response.sendRedirect("index.jsp?success=true");
    }
}
