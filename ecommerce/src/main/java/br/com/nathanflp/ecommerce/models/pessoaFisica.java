package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name="pessoa_fisica")

public class pessoaFisica extends pessoa {

    private static final long serialVersionUID= 1l;

    @Column(nullable = false)
    private String cpf;

    @Column(nullable = false)
    @Temporal(TemporalType.DATE)
    private Date data_nascimento;

}

