import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import dao.PatientDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Patient;

@SuppressWarnings("unused")
@jakarta.servlet.annotation.WebServlet("/manage-patients")
public class ManagePatientsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private PatientDAO patientDAO;

    public void init() {
        patientDAO = new PatientDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String patientId = request.getParameter("patientId");
        boolean patientFound = false; // Initialize patientFound to false

        if (patientId != null && !patientId.isEmpty()) {
            // Retrieve patient by ID and set it as an attribute
            int id = Integer.parseInt(patientId);
            Patient patient = patientDAO.getPatientById(id);

            if (patient != null) {
                patientFound = true; // Set patientFound to true if patient is found
                request.setAttribute("patient", patient);
            }
        }

        request.setAttribute("patientFound", patientFound); // Set the patientFound attribute

        // Forward to the manage_patients.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("manage_patients.jsp");
        dispatcher.forward(request, response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null && !action.isEmpty()) {
            if (action.equals("update")) {
                // Retrieve patient information from the request parameters
                int id = Integer.parseInt(request.getParameter("updatePatientId"));
                String name = request.getParameter("updatePatientName");
                String bloodType = request.getParameter("updatePatientBloodType");

                // Update the patient in the database
                Patient patient = new Patient(id, name, null, 0, 0, 0, bloodType);
                patientDAO.updatePatient(patient);
            } else if (action.equals("create")) {
                // Retrieve patient information from the request parameters
                String name = request.getParameter("createPatientName");
                String bloodType = request.getParameter("createPatientBloodType");

                // Create a new patient in the database
                Patient patient = new Patient(0, name, null, 0, 0, 0, bloodType);
                patientDAO.createPatient(patient);
            }
        }

        response.sendRedirect("index.jsp?success=true");
    }


    private void createPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int age = Integer.parseInt(request.getParameter("age"));
        double height = Double.parseDouble(request.getParameter("height"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        String bloodType = request.getParameter("bloodType");

        // Parse the date of birth from the string
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dateOfBirth = null;
        try {
            dateOfBirth = dateFormat.parse(dateOfBirthStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Patient patient = new Patient(0, name, dateOfBirth, age, height, weight, bloodType);
        patientDAO.createPatient(patient);

        response.sendRedirect("index.jsp?success=true");
    }

    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String dateOfBirthStr = request.getParameter("dateOfBirth");
        int age = Integer.parseInt(request.getParameter("age"));
        double height = Double.parseDouble(request.getParameter("height"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        String bloodType = request.getParameter("bloodType");

        // Parse the date of birth from the string
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date dateOfBirth = null;
        try {
            dateOfBirth = dateFormat.parse(dateOfBirthStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Patient patient = new Patient(id, name, dateOfBirth, age, height, weight, bloodType);
        patientDAO.updatePatient(patient);

        response.sendRedirect(request.getContextPath() + "/manage-patients");
    }
}