package br.com.nathanflp.ecommerce.models;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Entity
@Table(name="cupDesc")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_cup_desc", sequenceName = "seq_cup_desc", allocationSize = 1, initialValue = 1)

public class cupDesc {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_cup_desc")
    private Long id;

    @Column(nullable = false)
    private String codDesc;

    @Column(nullable = false)
    @Temporal(TemporalType.DATE)
    private Date dataValidade;

    private BigDecimal valorRealDesc;

    private BigDecimal valorPorcentDesc;

    @Temporal(TemporalType.DATE)
    private Date dataValidadeCupom;

}
