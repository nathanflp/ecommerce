package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="marca_produto")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_marca_produto", sequenceName = "seq_marca_produto", allocationSize = 1, initialValue = 1)

public class marcaProduto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_marca_produto")
    private Long id;

    @Column(nullable = false)
    private String nomeDesc;

}
