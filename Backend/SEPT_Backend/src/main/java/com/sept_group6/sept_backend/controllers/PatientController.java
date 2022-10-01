package com.sept_group6.sept_backend.controllers;

import com.sept_group6.sept_backend.dao.PatientRepository;
import com.sept_group6.sept_backend.model.Patient;
import com.sept_group6.sept_backend.security.JwtTokenProvider;
import com.sept_group6.sept_backend.security.CustomAuthenticationToken;
import com.sept_group6.sept_backend.payload.JWTLoginSucessReponse;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// security
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import com.sept_group6.sept_backend.payload.LoginRequest;
import static com.sept_group6.sept_backend.security.SecurityConstant.TOKEN_PREFIX;

// exception handling
import com.sept_group6.sept_backend.exception.EmailAlreadyExistsException;
import com.sept_group6.sept_backend.exception.GetRootException;
import org.springframework.transaction.TransactionSystemException;
import javax.transaction.RollbackException;
import javax.validation.ConstraintViolationException;
import javax.validation.Valid;

import java.util.Optional;

@RestController
@RequestMapping(path = "/patient")
public class PatientController {
    private static final Logger logger = LogManager.getLogger("Backend");
    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private JwtTokenProvider tokenProvider;

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    @PostMapping("/signin")
    public ResponseEntity<?> loginUser(@Valid @RequestBody LoginRequest loginRequest) {
        // String email = loginPatient.getEmail();
        // String password = loginPatient.getPassword();

        try {
            // throws exception if authentication doesn't pass
            Authentication authentication = authenticationManager.authenticate(
                    new CustomAuthenticationToken(
                            loginRequest.getEmail(),
                            loginRequest.getPassword(),
                            loginRequest.getUserType())

            );

            SecurityContextHolder.getContext().setAuthentication(authentication);
            String jwt = TOKEN_PREFIX + tokenProvider.generateToken(authentication);

            return ResponseEntity.ok(new JWTLoginSucessReponse(true, jwt));
        } catch (AuthenticationException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }

        // Optional<Patient> patient = patientRepository.findByEmailAndPassword(email,
        // password);

        // if (patient.isPresent()) {
        // return ResponseEntity.accepted().body(patient.get());
        // } else {
        // return ResponseEntity.badRequest().build();
        // }
    }

    @PostMapping(path = "/signup", consumes = "application/json", produces = "application/json")
    public ResponseEntity<?> addUser(@RequestBody Patient newPatient)
            throws Exception {
        logger.info(newPatient);
        try {
            // add resource
            if (patientRepository.existsByEmail(newPatient.getEmail())) {
                throw new EmailAlreadyExistsException("Email already exists.");
            }
            newPatient.setPassword(bCryptPasswordEncoder.encode(newPatient.getPassword()));
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
