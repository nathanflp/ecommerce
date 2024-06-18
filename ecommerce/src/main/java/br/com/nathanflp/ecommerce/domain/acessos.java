package br.com.nathanflp.ecommerce.domain;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;

@Entity
@Table(name="Acessos")
@Data
@NoArgsConstructor
@SequenceGenerator(name="seq_acesso", sequenceName = "seq_acesso", allocationSize = 1, initialValue = 1)

public class acessos implements GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_acesso")
    private Long id;

    @Column(nullable = false)
    private String descricao;

    @Override
    public String getAuthority() {
        return null;
    }
}
