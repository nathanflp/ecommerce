package br.com.nathanflp.ecommerce.models;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="vd_cp_loja_virt")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_vd_cp_loja_virt", sequenceName = "seq_vd_cp_loja_virt", allocationSize = 1, initialValue = 1)
public class vendaCompraLojaVirtual {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_vd_cp_loja_virt")
    private Long id;

    @ManyToOne
    @JoinColumn(name="pessoa_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private pessoa pessoa;

    @ManyToOne
    @JoinColumn(name="endereço_entrega_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "endereço_entrega_fk"))
    private endereco endereçoEntrega;

    @ManyToOne
    @JoinColumn(name="endereço_cobranca_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "endereço_cobranca_fk"))
    private endereco endereçoCobranca;

    private BigDecimal valorTotal;

    private BigDecimal valorDescesconto;

    @ManyToOne
    @JoinColumn(name="forma_pagamento_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "forma_pagamento_fk"))
    private formaPagamento formaPagamento;

    @OneToOne
    @JoinColumn(name="nota_fiscal_venda_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "nota_fiscal_venda_fk"))
    private notaFiscalVenda notaFiscalVenda;

    @ManyToOne
    @JoinColumn(name="cup_desc_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "cup_desc_fk"))
    private cupDesc cupDesc;

    private BigDecimal valorFrete;

    private Integer diaEntrega;

    @Temporal(TemporalType.DATE)
    private Date dataVenda;

    @Temporal(TemporalType.DATE)
    private Date dataEntrega;


}
