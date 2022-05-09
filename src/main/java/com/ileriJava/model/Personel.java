package com.ileriJava.model;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "PERSONEL")
@Getter
@Setter
public class Personel{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID")
    private Long id;

    @OneToOne(cascade = CascadeType.ALL)
    private User user;

    @ManyToMany(fetch = FetchType.EAGER,
            cascade =
                    {
                            CascadeType.DETACH,
                            CascadeType.MERGE,
                            CascadeType.REFRESH,
                            CascadeType.PERSIST
                    },
            targetEntity = Category.class)
    @JoinTable(name = "PERSONEL_CATEGORY",
            foreignKey = @ForeignKey(ConstraintMode.CONSTRAINT),
            inverseForeignKey = @ForeignKey(ConstraintMode.CONSTRAINT))
    private List<Category> categories;

}
