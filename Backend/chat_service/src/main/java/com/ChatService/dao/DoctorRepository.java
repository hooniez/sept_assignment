package com.ChatService.dao;

import com.ChatService.Doctor;

import java.util.Optional;

public interface DoctorRepository extends UserRepository<Doctor> {
    // Optional<Doctor> findByEmailAndPassword(String email, String password);

    // boolean existsByEmail(String Email);
}