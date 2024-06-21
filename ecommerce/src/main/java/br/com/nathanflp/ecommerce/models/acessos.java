package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

import java.util.Objects;

@Entity
@Table(name="Acessos")
@Data
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

    public acessos() {
    }

    public acessos(Long id, String descricao) {
        this.id = id;
        this.descricao = descricao;
    }

    public Long getId() {
        return id;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        acessos acessos = (acessos) o;
        return Objects.equals(id, acessos.id) && Objects.equals(descricao, acessos.descricao);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, descricao);
    }

    @Override
    public String toString() {
        return "acessos{" +
                "id=" + id +
                ", descricao='" + descricao + '\'' +
                '}';
    }
}
