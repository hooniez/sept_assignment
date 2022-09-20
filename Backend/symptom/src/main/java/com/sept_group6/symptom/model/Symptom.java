package com.sept_group6.symptom.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Symptom {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    private String email;
    private String symptomdescription;

    public Integer getId() {

        return id;
    }

    public String getEmail() {
        return email;
    }

    public String getSymptomdescription() {
        return symptomdescription;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSymptomdescription(String symptomdescription) {
        this.symptomdescription = symptomdescription;
    }
}
