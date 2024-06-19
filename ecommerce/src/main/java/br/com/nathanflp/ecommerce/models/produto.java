package br.com.nathanflp.ecommerce.models;


import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name="produto")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_produto", sequenceName = "seq_produto", allocationSize = 1, initialValue = 1)
public class produto {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_produto")
    private Long id;

    private String tipoUnidade;

    private String nome;

    private Boolean ativo = Boolean.TRUE;

    @Column(columnDefinition = "text", length = 2000)
    private String descricao;

//    Nota item produto

    private Double peso;

    private Double largura;

    private Double altura;

    private Double profundidade;

    private BigDecimal valorVenda = BigDecimal.ZERO;

    private Integer qtdEstoque = 0;

    private Integer qtdeAlertaEstoque = 0;

    private String linkYoutube;

    private Boolean alertaQtdEstoque = Boolean.FALSE;

    private Integer qtdClique = 0;

}
