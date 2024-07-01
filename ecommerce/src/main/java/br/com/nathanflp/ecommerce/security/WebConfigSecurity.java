package br.com.nathanflp.ecommerce.security;

import br.com.nathanflp.ecommerce.service.userDetailsService;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;



@Configuration
@EnableWebSecurity
public class WebConfigSecurity {

    userDetailsService userDetailsService;

    public void userDetailsService(userDetailsService user){
        this.userDetailsService = user;
    }

    protected void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder());
    }

}
