package it.si2001.demo.models;

import java.util.List;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cars")
public class Car {
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @ManyToMany(mappedBy = "car")
  private List<Reservation> reservations;
  
  // To ensure that a car can reserved by only one user at once
  @OneToOne(mappedBy = "car")
  private Reservation reservation;
  
  
  @Column(name = "brand")
  private String brand;
  
  @Column(name = "model")
  private String model;
  
  @Column(name = "license_plate")
  private String license_plate;
  
  @Column(name = "year")
  private int year;
  
  @Column(name = "isAvailable")
  private boolean isAvailable;
  
  @Column(name = "createdAt")
  private Date createdAt;
  
}
