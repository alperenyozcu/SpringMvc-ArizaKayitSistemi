package com.ileriJava.model;


import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;


@Entity
@Table(name = "FaultRecords")
@Getter
@Setter
public class FaultRecords implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "ID", nullable = false)
    private Long id;

    @Column(name = "TITLE", nullable = false)
    private String title;

    @Column(name = "IS_RESOLVED", nullable = false)
    private Boolean isResolved;

    @Column(name = "CREATION_TIME", nullable = false)
    @Temporal(TemporalType.DATE)
    private Date creationTime;

    @Column(name = "CONTEXT", nullable = false, columnDefinition = "TEXT")
    private String context;

    @Column(name = "IS_EXPIRED")
    private Boolean isExpired;

    //Bir Kullanıcı birden fazla başlık açabilir
    @ManyToOne
    @JoinColumn(name = "USER_ID", referencedColumnName = "ID")
    private User user;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "CATEGORY_ID", referencedColumnName = "ID")
    private Category category;
}
