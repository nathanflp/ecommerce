package br.com.nathanflp.ecommerce.service;

import br.com.nathanflp.ecommerce.repository.acessoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class acessoService {

    @Autowired
    public acessoRepository repository;

}
