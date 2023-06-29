package model;

import java.util.Date;

import dao.AppointmentDAO;

public class Appointment {
    private int id;
    private Patient patient;
    private Doctor doctor;
    private Date date;
    private String time;

    public Appointment(int id, Patient patient, Doctor doctor, Date date, String time) {
        this.id = id;
        this.patient = patient;
        this.doctor = doctor;
        this.date = date;
        this.time = time;
    }

    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
    
    public static void removeAppointmentById(int appointmentId) {
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        appointmentDAO.removeAppointmentById(appointmentId);
    }
}
