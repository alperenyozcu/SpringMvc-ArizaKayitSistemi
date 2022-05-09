package com.ileriJava.model;

import com.ileriJava.enums.UserRole;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "User")
@Getter
@Setter
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID", nullable = false)
    private Long id;

    @Column(name = "KULLANICI_ADI", nullable = false)
    private String kullaniciAdi;

    @Column(name = "AD", nullable = false)
    private String ad;

    @Column(name = "SOYAD", nullable = false)
    private String soyad;

    @Column(name = "EMAIL", nullable = false)
    private String email;

    @Column(name = "SIFRE", nullable = false)
    private String sifre;

    @Column(name = "ROLE", nullable = false)
    @Enumerated(EnumType.STRING)
    private UserRole role;
}