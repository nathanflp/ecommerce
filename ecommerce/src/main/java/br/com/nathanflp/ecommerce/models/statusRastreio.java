package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name="status_rastreio")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_status_rastreio", sequenceName = "seq_status_rastreio", allocationSize = 1, initialValue = 1)
public class statusRastreio {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_status_rastreio")
    private Long id;

    private String centroDistribuição;

    private String cidade;

    private String estado;

    private String status;

    @ManyToOne
    @JoinColumn(name="venda_compra_loja_virt_id",nullable = false,
    foreignKey = @ForeignKey(value = ConstraintMode.CONSTRAINT, name = "venda_compra_loja_virt_fk"))
    private vendaCompraLojaVirtual vendaCompraLojaVirtual;

}
