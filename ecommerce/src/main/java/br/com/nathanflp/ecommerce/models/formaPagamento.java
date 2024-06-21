package br.com.nathanflp.ecommerce.models;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Entity
@Table(name="formaPagamento")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_formaPagamento", sequenceName = "seq_formaPagamento", allocationSize = 1, initialValue = 1)
public class formaPagamento {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_formaPagamento")
    private Long id;

    @Column(nullable = false)
    private String descricao;

}
