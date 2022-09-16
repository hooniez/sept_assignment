package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequiredArgsConstructor
@RequestMapping(path="/patient")
public class PatientController {
    private static final Logger logger = LogManager.getLogger("Backend");
    private final PatientRepository patientRepository;

    @GetMapping("/signin")
    public ResponseEntity<?> loginPatient(@RequestParam("email") String email,
                                       @RequestParam("password") String password) {

        Optional<Patient> patient =
                patientRepository.findByEmailAndPassword(email, password);

        if (patient.isPresent()) {
            return ResponseEntity.ok().body(patient.get());
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @PostMapping(path = "/signup", consumes="application/json", produces =
            "application/json")
    public Patient addPatient(@RequestBody Patient newPatient)
            throws Exception {
        return patientRepository.save(newPatient);

    }
}
