package com.sept_group6.sept_backend.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;

@Entity
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long uid;
    @Email(message = "Email must be valid")
    @NotBlank(message = "Email is required")
    // uniqueness when adding new row needs to be checked in contronller
    @Column(unique = true)
    private String email;

    private String firstname;
    private String lastname;

    private String dob;
    @NotBlank(message = "Password is required")
    private String password;
    private String mobilenumber;
    private String certificate;

    public String toString() {
        return " email= " + email + " firstName= " + firstname + " lastName= " + lastname +
                " dob= " + dob + " password= " + password + " mobileNumber= " + mobilenumber + " certificate= "
                + certificate;
    }

}