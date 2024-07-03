package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@SequenceGenerator(name="seq_usuario", sequenceName = "seq_usuario", allocationSize = 1, initialValue = 1)
@Table(name="usuario")
@Data
@NoArgsConstructor

public class usuario{


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_usuario")
    private Long id;

    @Column(nullable = false)
    private String login;

    @Column(nullable = false)
    private String senha;

    @Column(nullable = false)
    @Temporal(TemporalType.DATE)
    private Date data_atua_senha;

    @ManyToOne
    @JoinColumn(name="pessoa_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private pessoa pessoa;

    @OneToMany
    @JoinTable(name = "usuarios_acesso", uniqueConstraints = @UniqueConstraint (columnNames = {"usuario_id", "acesso_id"} ,
    name = "unique_acesso_user"),

    joinColumns = @JoinColumn(name = "usuario_id", referencedColumnName = "id", table = "usuario",
        unique = false, foreignKey = @ForeignKey(name = "usuario_fk", value = ConstraintMode.CONSTRAINT)),

    inverseJoinColumns = @JoinColumn(name = "acesso_id", unique = false, referencedColumnName = "id", table = "acessos",
        foreignKey = @ForeignKey(name = "acesso_fk", value = ConstraintMode.CONSTRAINT)))

    List<acessos> acessos;

}
