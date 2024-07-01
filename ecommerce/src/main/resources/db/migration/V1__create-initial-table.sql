
-- PostgreSQL database dump
--

-- Dumped from database version 15.6
-- Dumped by pg_dump version 15.6

-- Started on 2024-06-22 13:11:47

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3533 (class 1262 OID 17170)
-- Name: ecommerce; Type: DATABASE; Schema: -; Owner: postgres
--

-- CREATE DATABASE ecommerce WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';


-- ALTER DATABASE ecommerce OWNER TO postgres;

-- \connect ecommerce

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 254 (class 1255 OID 17414)
-- Name: ValidaChavePessoaPessoa_forn_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."ValidaChavePessoaPessoa_forn_id"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

begin
	existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_forn_id) ;
		if (existe <= 0) then
			existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_forn_id);
		if (existe <= 0) then
			raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
			end if;
		end if;
end;
$$;


ALTER FUNCTION public."ValidaChavePessoaPessoa_forn_id"() OWNER TO postgres;

--
-- TOC entry 253 (class 1255 OID 17411)
-- Name: ValidaChavePessoaPessoa_id(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public."ValidaChavePessoaPessoa_id"() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare existe integer;

begin
	existe = (select count(1) from pessoa_fisica where id = NEW.pessoa_id) ;
		if (existe <= 0) then
			existe = (select count(1) from pessoa_juridica where id = NEW.pessoa_id);
		if (existe <= 0) then
			raise exception 'Não foi encontrado o ID ou PK da pessoa para realizar a associação';
			end if;
		end if;
		return new;
end;
$$;


ALTER FUNCTION public."ValidaChavePessoaPessoa_id"() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 17171)
-- Name: acessos; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.acessos (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.acessos OWNER TO dev;

--
-- TOC entry 215 (class 1259 OID 17176)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.avaliacao_produto (
    id bigint NOT NULL,
    descricao character varying(255),
    nota integer NOT NULL,
    pessoa_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO dev;

--
-- TOC entry 216 (class 1259 OID 17181)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.categoria_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO dev;

--
-- TOC entry 217 (class 1259 OID 17186)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.conta_pagar (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valo_total numeric(38,2) NOT NULL,
    valor_desconto numeric(38,2),
    pessoa_id bigint NOT NULL,
    pessoa_forn_id bigint NOT NULL,
    CONSTRAINT conta_pagar_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying, 'RENEGOCIADA'::character varying])::text[])))
);


ALTER TABLE public.conta_pagar OWNER TO dev;

--
-- TOC entry 218 (class 1259 OID 17194)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.conta_receber (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL,
    dt_pagamento date,
    dt_vencimento date NOT NULL,
    status character varying(255) NOT NULL,
    valo_total numeric(38,2) NOT NULL,
    valor_desconto numeric(38,2),
    pessoa_id bigint NOT NULL,
    CONSTRAINT conta_receber_status_check CHECK (((status)::text = ANY ((ARRAY['COBRANCA'::character varying, 'VENCIDA'::character varying, 'ABERTA'::character varying, 'QUITADA'::character varying])::text[])))
);


ALTER TABLE public.conta_receber OWNER TO dev;

--
-- TOC entry 219 (class 1259 OID 17202)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.cup_desc (
    id bigint NOT NULL,
    cod_desc character varying(255) NOT NULL,
    data_validade date NOT NULL,
    data_validade_cupom date,
    valor_porcent_desc numeric(38,2),
    valor_real_desc numeric(38,2)
);


ALTER TABLE public.cup_desc OWNER TO dev;

--
-- TOC entry 220 (class 1259 OID 17207)
-- Name: endereco; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.endereco (
    id bigint NOT NULL,
    bairro character varying(255) NOT NULL,
    cep character varying(255) NOT NULL,
    cidade character varying(255) NOT NULL,
    complemento character varying(255),
    numero character varying(255) NOT NULL,
    rua_logra character varying(255) NOT NULL,
    "tipo_endereço" character varying(255) NOT NULL,
    uf character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL,
    CONSTRAINT "endereco_tipo_endereço_check" CHECK ((("tipo_endereço")::text = ANY ((ARRAY['COBRANCA'::character varying, 'ENTREGA'::character varying])::text[])))
);


ALTER TABLE public.endereco OWNER TO dev;

--
-- TOC entry 221 (class 1259 OID 17215)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.forma_pagamento (
    id bigint NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO dev;

--
-- TOC entry 222 (class 1259 OID 17220)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.imagem_produto (
    id bigint NOT NULL,
    imagem_miniatura text NOT NULL,
    imagem_original text NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO dev;

--
-- TOC entry 223 (class 1259 OID 17227)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.item_venda_loja (
    id bigint NOT NULL,
    quantidade text NOT NULL,
    produto_id bigint NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO dev;

--
-- TOC entry 224 (class 1259 OID 17234)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.marca_produto (
    id bigint NOT NULL,
    nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO dev;

--
-- TOC entry 225 (class 1259 OID 17239)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.nota_fiscal_compra (
    id bigint NOT NULL,
    data_compra date NOT NULL,
    descricao_obs character varying(255),
    serie_nota character varying(255) NOT NULL,
    valor_desconto numeric(38,2),
    valor_icms numeric(38,2) NOT NULL,
    valor_total numeric(38,2) NOT NULL,
    conta_pagar_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO dev;

--
-- TOC entry 226 (class 1259 OID 17246)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.nota_fiscal_venda (
    id bigint NOT NULL,
    numero character varying(255) NOT NULL,
    pdf text NOT NULL,
    serie character varying(255) NOT NULL,
    tipo character varying(255) NOT NULL,
    xml text NOT NULL,
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO dev;

--
-- TOC entry 227 (class 1259 OID 17253)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.nota_item_produto (
    id bigint NOT NULL,
    quantidade double precision NOT NULL,
    nota_fiscal_compra_id bigint NOT NULL,
    produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO dev;

--
-- TOC entry 228 (class 1259 OID 17258)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.pessoa_fisica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    cpf character varying(255) NOT NULL,
    data_nascimento date NOT NULL
);


ALTER TABLE public.pessoa_fisica OWNER TO dev;

--
-- TOC entry 229 (class 1259 OID 17265)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.pessoa_juridica (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(255) NOT NULL,
    categoria character varying(255) NOT NULL,
    cnpj character varying(255) NOT NULL,
    insc_estadual character varying(255) NOT NULL,
    insc_municipal character varying(255) NOT NULL,
    nome_fantasia character varying(255) NOT NULL,
    razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO dev;

--
-- TOC entry 230 (class 1259 OID 17272)
-- Name: produto; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.produto (
    id bigint NOT NULL,
    alerta_qtd_estoque boolean,
    altura double precision NOT NULL,
    ativo boolean,
    descricao text NOT NULL,
    largura double precision NOT NULL,
    link_youtube character varying(255),
    nome character varying(255) NOT NULL,
    peso double precision NOT NULL,
    profundidade double precision NOT NULL,
    qtd_clique integer,
    qtd_estoque integer NOT NULL,
    qtde_alerta_estoque integer,
    tipo_unidade character varying(255) NOT NULL,
    valor_venda numeric(38,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO dev;

--
-- TOC entry 235 (class 1259 OID 17309)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO dev;

--
-- TOC entry 236 (class 1259 OID 17310)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto OWNER TO dev;

--
-- TOC entry 237 (class 1259 OID 17311)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto OWNER TO dev;

--
-- TOC entry 238 (class 1259 OID 17312)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber OWNER TO dev;

--
-- TOC entry 239 (class 1259 OID 17313)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc OWNER TO dev;

--
-- TOC entry 240 (class 1259 OID 17314)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO dev;

--
-- TOC entry 241 (class 1259 OID 17315)
-- Name: seq_forma_pagamento; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_forma_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_forma_pagamento OWNER TO dev;

--
-- TOC entry 242 (class 1259 OID 17316)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto OWNER TO dev;

--
-- TOC entry 243 (class 1259 OID 17317)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja OWNER TO dev;

--
-- TOC entry 244 (class 1259 OID 17318)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto OWNER TO dev;

--
-- TOC entry 245 (class 1259 OID 17319)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra OWNER TO dev;

--
-- TOC entry 246 (class 1259 OID 17320)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda OWNER TO dev;

--
-- TOC entry 247 (class 1259 OID 17321)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto OWNER TO dev;

--
-- TOC entry 248 (class 1259 OID 17322)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO dev;

--
-- TOC entry 249 (class 1259 OID 17323)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO dev;

--
-- TOC entry 250 (class 1259 OID 17324)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio OWNER TO dev;

--
-- TOC entry 251 (class 1259 OID 17325)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO dev;

--
-- TOC entry 252 (class 1259 OID 17326)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: dev
--

CREATE SEQUENCE public.seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt OWNER TO dev;

--
-- TOC entry 231 (class 1259 OID 17279)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.status_rastreio (
    id bigint NOT NULL,
    "centro_distribuição" character varying(255),
    cidade character varying(255),
    estado character varying(255),
    status character varying(255),
    venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO dev;

--
-- TOC entry 232 (class 1259 OID 17286)
-- Name: usuario; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.usuario (
    id bigint NOT NULL,
    data_atua_senha date NOT NULL,
    login character varying(255) NOT NULL,
    senha character varying(255) NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO dev;

--
-- TOC entry 233 (class 1259 OID 17293)
-- Name: usuarios_acesso; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.usuarios_acesso (
    usuario_id bigint NOT NULL,
    acesso_id bigint NOT NULL
);


ALTER TABLE public.usuarios_acesso OWNER TO dev;

--
-- TOC entry 234 (class 1259 OID 17296)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: dev
--

CREATE TABLE public.vd_cp_loja_virt (
    id bigint NOT NULL,
    data_entrega date NOT NULL,
    data_venda date NOT NULL,
    dia_entrega integer NOT NULL,
    valor_descesconto numeric(38,2),
    valor_frete numeric(38,2) NOT NULL,
    valor_total numeric(38,2),
    cup_desc_id bigint,
    "endereço_cobranca_id" bigint NOT NULL,
    "endereço_entrega_id" bigint NOT NULL,
    forma_pagamento_id bigint NOT NULL,
    nota_fiscal_venda_id bigint NOT NULL,
    pessoa_id bigint NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt OWNER TO dev;

--
-- TOC entry 3489 (class 0 OID 17171)
-- Dependencies: 214
-- Data for Name: acessos; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3490 (class 0 OID 17176)
-- Dependencies: 215
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: dev
--

INSERT INTO public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) VALUES (1, 'teste trigger', 10, 1, 1);
INSERT INTO public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) VALUES (5, 'teste trigger', 10, 1, 1);
INSERT INTO public.avaliacao_produto (id, descricao, nota, pessoa_id, produto_id) VALUES (8, 'teste trigger', 10, 1, 1);


--
-- TOC entry 3491 (class 0 OID 17181)
-- Dependencies: 216
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3492 (class 0 OID 17186)
-- Dependencies: 217
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3493 (class 0 OID 17194)
-- Dependencies: 218
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3494 (class 0 OID 17202)
-- Dependencies: 219
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3495 (class 0 OID 17207)
-- Dependencies: 220
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3496 (class 0 OID 17215)
-- Dependencies: 221
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3497 (class 0 OID 17220)
-- Dependencies: 222
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3498 (class 0 OID 17227)
-- Dependencies: 223
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3499 (class 0 OID 17234)
-- Dependencies: 224
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3500 (class 0 OID 17239)
-- Dependencies: 225
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3501 (class 0 OID 17246)
-- Dependencies: 226
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3502 (class 0 OID 17253)
-- Dependencies: 227
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3503 (class 0 OID 17258)
-- Dependencies: 228
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: dev
--

INSERT INTO public.pessoa_fisica (id, email, nome, telefone, cpf, data_nascimento) VALUES (1, 'dwandwandwna', 'nathan', '32142314214', '5316316', '1998-04-13');


--
-- TOC entry 3504 (class 0 OID 17265)
-- Dependencies: 229
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3505 (class 0 OID 17272)
-- Dependencies: 230
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: dev
--

INSERT INTO public.produto (id, alerta_qtd_estoque, altura, ativo, descricao, largura, link_youtube, nome, peso, profundidade, qtd_clique, qtd_estoque, qtde_alerta_estoque, tipo_unidade, valor_venda) VALUES (1, true, 10.4, true, 'produto teste', 50.2, 'dwamdkadwkadkadska', 'nome produto teste', 60.7, 70.5, 50, 1, 1, 'UN', 50.00);


--
-- TOC entry 3506 (class 0 OID 17279)
-- Dependencies: 231
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3507 (class 0 OID 17286)
-- Dependencies: 232
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3508 (class 0 OID 17293)
-- Dependencies: 233
-- Data for Name: usuarios_acesso; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3509 (class 0 OID 17296)
-- Dependencies: 234
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: dev
--



--
-- TOC entry 3534 (class 0 OID 0)
-- Dependencies: 235
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 3535 (class 0 OID 0)
-- Dependencies: 236
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 3536 (class 0 OID 0)
-- Dependencies: 237
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 3537 (class 0 OID 0)
-- Dependencies: 238
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 3538 (class 0 OID 0)
-- Dependencies: 239
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 3539 (class 0 OID 0)
-- Dependencies: 240
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 3540 (class 0 OID 0)
-- Dependencies: 241
-- Name: seq_forma_pagamento; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_forma_pagamento', 1, false);


--
-- TOC entry 3541 (class 0 OID 0)
-- Dependencies: 242
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 3542 (class 0 OID 0)
-- Dependencies: 243
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 3543 (class 0 OID 0)
-- Dependencies: 244
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 3544 (class 0 OID 0)
-- Dependencies: 245
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 3545 (class 0 OID 0)
-- Dependencies: 246
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 3546 (class 0 OID 0)
-- Dependencies: 247
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 3547 (class 0 OID 0)
-- Dependencies: 248
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 3548 (class 0 OID 0)
-- Dependencies: 249
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 3549 (class 0 OID 0)
-- Dependencies: 250
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 3550 (class 0 OID 0)
-- Dependencies: 251
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 3551 (class 0 OID 0)
-- Dependencies: 252
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: dev
--

SELECT pg_catalog.setval('public.seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 3276 (class 2606 OID 17175)
-- Name: acessos acessos_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.acessos
    ADD CONSTRAINT acessos_pkey PRIMARY KEY (id);


--
-- TOC entry 3278 (class 2606 OID 17180)
-- Name: avaliacao_produto avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3280 (class 2606 OID 17185)
-- Name: categoria_produto categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3282 (class 2606 OID 17193)
-- Name: conta_pagar conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 3284 (class 2606 OID 17201)
-- Name: conta_receber conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 3286 (class 2606 OID 17206)
-- Name: cup_desc cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 3288 (class 2606 OID 17214)
-- Name: endereco endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 3290 (class 2606 OID 17219)
-- Name: forma_pagamento forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 3292 (class 2606 OID 17226)
-- Name: imagem_produto imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3294 (class 2606 OID 17233)
-- Name: item_venda_loja item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 3296 (class 2606 OID 17238)
-- Name: marca_produto marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3298 (class 2606 OID 17245)
-- Name: nota_fiscal_compra nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 3300 (class 2606 OID 17252)
-- Name: nota_fiscal_venda nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 3304 (class 2606 OID 17257)
-- Name: nota_item_produto nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3306 (class 2606 OID 17264)
-- Name: pessoa_fisica pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 3308 (class 2606 OID 17271)
-- Name: pessoa_juridica pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 3310 (class 2606 OID 17278)
-- Name: produto produto_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 3312 (class 2606 OID 17285)
-- Name: status_rastreio status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 3302 (class 2606 OID 17302)
-- Name: nota_fiscal_venda uk3sg7y5xs15vowbpi2mcql08kg; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT uk3sg7y5xs15vowbpi2mcql08kg UNIQUE (venda_compra_loja_virt_id);


--
-- TOC entry 3316 (class 2606 OID 17306)
-- Name: usuarios_acesso uk8bak9jswon2id2jbunuqlfl9e; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT uk8bak9jswon2id2jbunuqlfl9e UNIQUE (acesso_id);


--
-- TOC entry 3320 (class 2606 OID 17308)
-- Name: vd_cp_loja_virt ukhkxjejv08kldx994j4serhrbu; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT ukhkxjejv08kldx994j4serhrbu UNIQUE (nota_fiscal_venda_id);


--
-- TOC entry 3318 (class 2606 OID 17304)
-- Name: usuarios_acesso unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 3314 (class 2606 OID 17292)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 3322 (class 2606 OID 17300)
-- Name: vd_cp_loja_virt vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 2620 OID 17412)
-- Name: avaliacao_produto validaChavePessoaAvalicaoProduto; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaAvalicaoProduto" BEFORE INSERT OR UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3340 (class 2620 OID 17413)
-- Name: conta_pagar validaChavePessoaContaPagar; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaContaPagar" BEFORE INSERT OR UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3341 (class 2620 OID 17415)
-- Name: conta_pagar validaChavePessoaContaPagar2; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaContaPagar2" BEFORE INSERT OR UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_forn_id"();


--
-- TOC entry 3342 (class 2620 OID 17416)
-- Name: conta_receber validaChavePessoaContaReceber; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaContaReceber" BEFORE INSERT OR UPDATE ON public.conta_receber FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3343 (class 2620 OID 17417)
-- Name: endereco validaChavePessoaEndereco; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaEndereco" BEFORE INSERT OR UPDATE ON public.endereco FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3344 (class 2620 OID 17418)
-- Name: nota_fiscal_compra validaChavePessoaNotaFiscalCompra; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaNotaFiscalCompra" BEFORE INSERT OR UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3345 (class 2620 OID 17419)
-- Name: usuario validaChavePessoaUsuario; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaUsuario" BEFORE INSERT OR UPDATE ON public.usuario FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3346 (class 2620 OID 17420)
-- Name: vd_cp_loja_virt validaChavePessoaVendaCompraLojaVirt; Type: TRIGGER; Schema: public; Owner: dev
--

CREATE TRIGGER "validaChavePessoaVendaCompraLojaVirt" BEFORE INSERT OR UPDATE ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE FUNCTION public."ValidaChavePessoaPessoa_id"();


--
-- TOC entry 3332 (class 2606 OID 17372)
-- Name: usuarios_acesso acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acessos(id);


--
-- TOC entry 3327 (class 2606 OID 17347)
-- Name: nota_fiscal_compra conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 3334 (class 2606 OID 17382)
-- Name: vd_cp_loja_virt cup_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT cup_desc_fk FOREIGN KEY (cup_desc_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 3335 (class 2606 OID 17387)
-- Name: vd_cp_loja_virt endereço_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT "endereço_cobranca_fk" FOREIGN KEY ("endereço_cobranca_id") REFERENCES public.endereco(id);


--
-- TOC entry 3336 (class 2606 OID 17392)
-- Name: vd_cp_loja_virt endereço_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT "endereço_entrega_fk" FOREIGN KEY ("endereço_entrega_id") REFERENCES public.endereco(id);


--
-- TOC entry 3337 (class 2606 OID 17397)
-- Name: vd_cp_loja_virt forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 3329 (class 2606 OID 17357)
-- Name: nota_item_produto nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 3338 (class 2606 OID 17402)
-- Name: vd_cp_loja_virt nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 3323 (class 2606 OID 17327)
-- Name: avaliacao_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3324 (class 2606 OID 17332)
-- Name: imagem_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3325 (class 2606 OID 17337)
-- Name: item_venda_loja produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3330 (class 2606 OID 17362)
-- Name: nota_item_produto produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 3333 (class 2606 OID 17377)
-- Name: usuarios_acesso usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.usuarios_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 3326 (class 2606 OID 17342)
-- Name: item_venda_loja venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 3328 (class 2606 OID 17352)
-- Name: nota_fiscal_venda venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 3331 (class 2606 OID 17367)
-- Name: status_rastreio venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: dev
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


-- Completed on 2024-06-22 13:11:47

--
-- PostgreSQL database dump complete
--

