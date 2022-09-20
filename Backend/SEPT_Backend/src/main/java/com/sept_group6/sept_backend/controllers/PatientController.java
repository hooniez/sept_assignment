package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// exception handling
import com.sept_group6.sept_backend.exception.EmailAlreadyExistsException;
import com.sept_group6.sept_backend.exception.GetRootException;
import org.springframework.transaction.TransactionSystemException;
import javax.transaction.RollbackException;
import javax.validation.ConstraintViolationException;

import java.util.Optional;

@RestController
@RequestMapping(path = "/patient")
public class PatientController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;

    @PostMapping("/signin")
    public ResponseEntity<?> loginUser(@RequestBody Patient loginPatient) {
        String email = loginPatient.getEmail();
        String password = loginPatient.getPassword();

        Optional<Patient> patient = patientRepository.findByEmailAndPassword(email, password);

        if (patient.isPresent()) {
            return ResponseEntity.accepted().body(patient.get());
        } else {
            return ResponseEntity.badRequest().build();
        }
    }

    @PutMapping(path = "/signup", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> addUser(@RequestBody Patient newPatient)
            throws Exception {
        logger.info(newPatient);
        try {
            // add resource
            if (patientRepository.existsByEmail(newPatient.getEmail())) {
                throw new EmailAlreadyExistsException("Email already exists.");
            }
            Patient patient = patientRepository.save(newPatient);

            return ResponseEntity.accepted().body(patient);
        } catch (EmailAlreadyExistsException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        } catch (ConstraintViolationException e) {
            String errorMessage = "";
            for (var error : e.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            return ResponseEntity.badRequest().body(errorMessage);
        } catch (TransactionSystemException e) {
            ConstraintViolationException causeException = (ConstraintViolationException) GetRootException
                    .getRootException(e);
            String errorMessage = "";
            for (var error : causeException.getConstraintViolations()) {
                errorMessage += error.getMessage() + "\n";
            }
            return ResponseEntity.badRequest().body(errorMessage);
        }

    }
}
