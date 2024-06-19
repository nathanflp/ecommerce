package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="nota_item_produto")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_nota_item_produto", sequenceName = "seq_nota_item_produto", allocationSize = 1, initialValue = 1)
public class notaItemProduto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_nota_item_produto")
    private Long id;

    @Column(nullable = false)
    private Double quantidade;

    @ManyToOne
    @JoinColumn(name="nota_fiscal_compra_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "nota_fiscal_compra_fk"))
    private notaFiscalCompra notaFiscalCompra;

    @ManyToOne
    @JoinColumn(name="produto_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "produto_fk"))
    private produto produto;

}
