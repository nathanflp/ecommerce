package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="categoria_produto")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_categoria_produto", sequenceName = "seq_categoria_produto", allocationSize = 1, initialValue = 1)

public class categoriaProduto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,generator = "seq_categoria_produto")
    private Long id;

    @Column(nullable = false)
    private String nomeDesc;
}
