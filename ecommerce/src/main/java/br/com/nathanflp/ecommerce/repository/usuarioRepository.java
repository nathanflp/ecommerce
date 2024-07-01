package br.com.nathanflp.ecommerce.repository;

import br.com.nathanflp.ecommerce.models.usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;


public interface usuarioRepository extends JpaRepository<usuario, Long> {

    @Query(value = "select a from usuario a where a.login = ?1")
    usuario findUserByLogin(String login);
}
