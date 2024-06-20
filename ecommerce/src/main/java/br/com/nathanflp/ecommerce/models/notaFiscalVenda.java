package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity
@Table(name="nota_fiscal_venda")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_nota_fiscal_venda", sequenceName = "seq_nota_fiscal_venda", allocationSize = 1, initialValue = 1)
public class notaFiscalVenda {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_nota_fiscal_venda")
    private Long id;

    private String number;

    private String serie;

    private String tipo;

    @OneToOne
    @JoinColumn(name="venda_compra_loja_virt_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "venda_compra_loja_virt_fk"))
    private vendaCompraLojaVirtual vendaCompraLojaVirtual;

    @Column(columnDefinition = "text")
    private String xml;

    @Column(columnDefinition = "text")
    private String pdf;

}
