package br.com.nathanflp.ecommerce.domain;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name="pessoa_fisica")

public class pessoaFisica extends pessoa {

    private static final long serialVersionUID= 1l;

    @PrimaryKeyJoinColumn(name = "id")
    private Long id;

    @Column(nullable = false)
    private String cpf;

    @Temporal(TemporalType.DATE)
    private Date data_nascimento;

}

