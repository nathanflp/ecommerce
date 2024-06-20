package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="item_venda_loja")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_item_venda_loja", sequenceName = "seq_item_venda_loja", allocationSize = 1, initialValue = 1)
public class itemVendaLoja {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_item_venda_loja")
    private Long id;

    private Double quantidade;

    @ManyToOne
    @JoinColumn(name="produto_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "produto_fk"))
    private produto produto;


    @ManyToOne
    @JoinColumn(name="venda_compra_loja_virt_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "venda_compra_loja_virt_fk"))
    private vendaCompraLojaVirtual vendaCompraLojaVirtual;

}
