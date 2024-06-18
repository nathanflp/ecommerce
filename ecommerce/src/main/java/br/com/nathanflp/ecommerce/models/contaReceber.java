package br.com.nathanflp.ecommerce.models;
import br.com.nathanflp.ecommerce.enums.statusContaReceber;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

@Entity
@SequenceGenerator(name = "seq_contaReceber", sequenceName = "seq_contaReceber", allocationSize = 1,initialValue = 1)
@Table(name="contaReceber")
@Data
@NoArgsConstructor

public class contaReceber implements Serializable {

    private static final long serialVersionUID= 1l;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_contaReceber")
    private Long id;

    private String descricao;

    @Enumerated(EnumType.STRING)
    private statusContaReceber status;

    @Temporal(TemporalType.DATE)
    private Date dtPagamento;

    private BigDecimal valoTotal;

    private BigDecimal valorDesconto;

    @ManyToOne(targetEntity = pessoa.class)
    @JoinColumn(name="pessoa_id",nullable = false,foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "pessoa_fk"))
    private pessoa pessoa;

}
