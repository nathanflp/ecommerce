package br.com.nathanflp.ecommerce.models;

import jakarta.persistence.*;


@Entity
@Table(name="pessoa_juridica")

public class pessoaJuridica extends pessoa {

        private static final long serialVersionUID= 1l;

        @PrimaryKeyJoinColumn(name = "id")
        private Long id;

        @Column(nullable = false)
        private String cnpj;

        @Column(nullable = false)
        private String inscMunicipal;

        @Column(nullable = false)
        private String inscEstadual;

        @Column(nullable = false)
        private String nomeFantasia;

        @Column(nullable = false)
        private String razaoSocial;

        @Column(nullable = false)
        private String categoria;

    }

