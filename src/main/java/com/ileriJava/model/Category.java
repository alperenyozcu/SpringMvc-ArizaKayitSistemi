package com.ileriJava.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @author furkancelik
 **/

@Entity
@Table(name = "CATEGORY")
@Getter
@Setter
public class Category implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID")
    private Long id;

    @Column(name = "NAME", columnDefinition = "TEXT")
    private String name;

    @Column(name = "DESCRIPTION", columnDefinition = "TEXT")
    private String description;
//
//    @ManyToOne
//    @OnDelete(action = OnDeleteAction.CASCADE)
//    @JoinColumn(name = "PERSONEL_ID", referencedColumnName = "ID")
//    private Personel personel;
}
