package br.com.nathanflp.ecommerce.domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Entity
@SequenceGenerator(name = "seq_endereco", sequenceName = "seq_endereco", allocationSize = 1,initialValue = 1)
@Table(name="endereco")
@Data
@NoArgsConstructor
public class endereco implements Serializable {

    private static final long serialVersionUID= 1l;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_endereco")
    private Long id;

    private String rua_logra;

    private String cep;

    private String numero;

    private String complemento;

    private String bairro;

    private String uf;

    private String cidade;

    @ManyToOne(targetEntity = pessoa.class)
    @JoinColumn(name="pessoa_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private pessoa pessoa;


}
