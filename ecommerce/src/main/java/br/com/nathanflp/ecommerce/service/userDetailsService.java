package br.com.nathanflp.ecommerce.service;

import br.com.nathanflp.ecommerce.models.usuario;
import br.com.nathanflp.ecommerce.repository.usuarioRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

public class userDetailsService implements UserDetailsService {

    @Autowired
    usuarioRepository repository;

    public UserDetails findUserByLogin(String username){

        usuario user = repository.findUserByLogin(username);

        if(user == null){
        throw new UsernameNotFoundException("Usuario não encontrado");
        }
        return new User(user.getLogin(),user.getPassword(),user.getAuthorities());
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return null;
    }
}
