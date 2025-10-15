package it.si2001.demo.models;

import java.util.List;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "reservations")
public class Reservation {
  
  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  
  @ManyToOne
  @JoinColumn(name = "user_id", referencedColumnName = "id")
  private User user;
  
  @ManyToMany
  @JoinTable(
    name = "cars_reservations",
    joinColumns = @JoinColumn(name = "reservation_id", referencedColumnName = "id"),
    inverseJoinColumns = @JoinColumn(name = "car_id", referencedColumnName = "id")
  )
  private List<Car> cars;
  
  // To ensure that a car can reserved by only one user at once
  @OneToOne
  @JoinColumn(
    name = "car_id", 
    unique = true, 
    nullable = false // each reservation must have at least one car
  )
  private Car car;
  
  
  @Column(name = "startedAt")
  private Date startedAt;
  
  @Column(name = "endedAt")
  private Date endedAt;
  
  @Column(name = "status")
  private String status;
  
  @Column(name = "createdAt")
  private Date createdAt;
  
}
