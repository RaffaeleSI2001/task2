package it.si2001.demo.models;

import java.util.List;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "users")
public class User {
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @OneToMany(mappedBy = "user") // (0,n) by default
  private List<Reservation> reservations;
  
  
  @Column(name = "firstName")
  private String firstName;
  
  @Column(name = "lastName")
  private String lastName;
  
  @Column(name = "age")
  private int age;
  
  @Column(name = "email")
  private String email;
  
  @Column(name = "password")
  private String password;
  
  @Column(name = "role")
  private String role; // ADMIN or CUSTOMER
  
  @Column(name = "createdAt")
  private Date createdAt;
  
}
