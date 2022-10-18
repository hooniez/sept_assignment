package com.sept_group6.appointment_server.controllers;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.sept_group6.appointment_server.dao.*;
import com.sept_group6.appointment_server.model.*;
import com.sept_group6.appointment_server.security.CustomAuthenticationToken;

import java.util.Optional;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(path = "/appointment")
public class AppointmentController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;
    @Autowired
    private DoctorRepository doctorRepository;
    @Autowired
    private AppointmentRepository appointmentRepository;

    // gets all booked & unbooked appointments related to the user
    @GetMapping("")
    public ResponseEntity<?> getAppointment(CustomAuthenticationToken authentication) {
        // logger.info(email + " " + usertype);
        String email = authentication.getName();
        String usertype = authentication.getUserType();
        Optional<List<Appointment>> appointments;
        if (usertype.equals("patient")) {
            appointments = appointmentRepository.findByPatientEmail(email);
        } else {
            appointments = appointmentRepository.findByDoctorEmail(email);
        }
        logger.info(appointments);
        if (appointments.isPresent()) {
            var appointmentViews = appointments.get().stream().map(Appointment::createView)
                    .collect(Collectors.toList());
            return ResponseEntity.accepted().body(appointmentViews);
        } else {
            return ResponseEntity.badRequest().build();
        }

    }

    // better to refactor this part to make it more readable.

    // update a unbooked appointment
    @PutMapping("")
    public ResponseEntity<?> makeAppointment(@RequestBody AppointmentView newView,
            CustomAuthenticationToken authentication) {

        if (!authentication.getUserType().equals("patient")) {
            return ResponseEntity.badRequest().body("User type must be patient!");
        }
        // patient name is email here
        String patientEmail = newView.getPatientName();
        if (patientEmail != null && !patientEmail.isEmpty()) {
            logger.info("patient make appointment");
            logger.info(newView);
            // patient updates an existing entry
            Optional<Appointment> appointment;
            appointment = appointmentRepository.findById(newView.getId());
            if (appointment.isPresent()) {
                appointment.get().setPatient(patientRepository.findByEmail(patientEmail));
                appointment.get().setAppointmentbooked(true);
                Appointment savedAppointment = appointmentRepository.save(appointment.get());
                AppointmentView savedView = savedAppointment.createView();
                return ResponseEntity.accepted().body(savedView);
            }
        }

        return ResponseEntity.badRequest().build();
    }
}
