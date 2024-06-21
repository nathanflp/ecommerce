package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="imagem_produto")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_imagem_produto", sequenceName = "seq_imagem_produto", allocationSize = 1, initialValue = 1)
public class imagemProduto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_imagem_produto")
    private Long id;

    @Column(columnDefinition = "text", nullable = false)
    private String imagemOriginal;

    @Column(columnDefinition = "text", nullable = false)
    private String imagemMiniatura;

    @ManyToOne
    @JoinColumn(name="produto_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "produto_fk"))
    private produto produto;
}
