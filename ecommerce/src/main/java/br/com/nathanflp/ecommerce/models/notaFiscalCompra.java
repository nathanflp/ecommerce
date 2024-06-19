package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="nota_fiscal_compra")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_nota_fiscal_compra", sequenceName = "seq_nota_fiscal_compra", allocationSize = 1, initialValue = 1)
public class notaFiscalCompra {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_nota_fiscal_compra")
    private Long id;

    private String serieNota;

    private String descricaoObs;

    private BigDecimal valorTotal;

    private BigDecimal valorDesconto;

    private BigDecimal valorIcms;

    @Temporal(TemporalType.DATE)
    private Date dataCompra;

    @ManyToOne
    @JoinColumn(name="pessoa_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private pessoa pessoa;

    @ManyToOne
    @JoinColumn(name="conta_pagar_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "conta_pagar_fk"))
    private contaPagar contaPagar;

}
