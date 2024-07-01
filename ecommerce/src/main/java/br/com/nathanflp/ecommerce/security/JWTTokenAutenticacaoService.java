package br.com.nathanflp.ecommerce.security;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;

import java.util.Date;


@Service
public class JWTTokenAutenticacaoService {

    //Tempo de experição do token = 3 Dias
    private static final long tempoParaExpirar = 959990000;

    //Chave para concatenar com o JWT
    private static final String secretPassword = "123";

    //Prefixo do token
    private static final String prefixoToken = "Bearer";

    private static final String headerString = "Authorization";


    public void addAuthentication(HttpServletResponse response, String username) throws Exception{

        String JWT = Jwts.builder(). // chama o gerador do token
                setSubject(username). // seta o user
                setExpiration(new Date(System.currentTimeMillis() + tempoParaExpirar)) // Seta a data para expiração
                .signWith(SignatureAlgorithm.HS512, secretPassword).compact();

        // Padrao do token
        String token = prefixoToken + " " + JWT;

        // Response pro client
        response.addHeader(headerString,token);

        // Response no body
        response.getWriter().write("{\"Authorization\": \"" + token + "\"}");
    }
}



