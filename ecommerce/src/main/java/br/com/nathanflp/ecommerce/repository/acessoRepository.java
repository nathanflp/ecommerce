package br.com.nathanflp.ecommerce.repository;

import br.com.nathanflp.ecommerce.models.acessos;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface acessoRepository extends JpaRepository <acessos, Long> {
}
