package com.sept_group6.sept_backend.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Symptom {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    private Integer patientid;
    private String symptomnumber;
    private String symptomdescription;

    public Integer getId() {

        return id;
    }

    public Integer getPatientid() {
        return patientid;
    }

    public String getSymptomnumber() {
        return symptomnumber;
    }

    public String getSymptomdescription() {
        return symptomdescription;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setPatientid(Integer patientid) {
        this.patientid = patientid;
    }

    public void setSymptomnumber(String symptomnumber) {
        this.symptomnumber = symptomnumber;
    }

    public void setSymptomdescription(String symptomdescription) {
        this.symptomdescription = symptomdescription;
    }
}