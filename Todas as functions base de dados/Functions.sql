
-- Cria a tabela Carteira.

CREATE TABLE IF NOT EXISTS public.carteira
(
    id_carteira integer NOT NULL DEFAULT nextval('carteira_id_carteira_seq1'::regclass),
    saldo numeric(10,2) NOT NULL DEFAULT 0.0,
    id_pessoa integer NOT NULL,
    CONSTRAINT carteira_pkey PRIMARY KEY (id_carteira),
    CONSTRAINT fk_pessoa FOREIGN KEY (id_pessoa)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.carteira
    OWNER to postgres;
	
	


-- Cria a tabela Categoria

CREATE TABLE IF NOT EXISTS public.categoria
(
    id_categoria integer NOT NULL DEFAULT nextval('categoria_id_categoria_seq'::regclass),
    nome_categoria character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT categoria_pkey PRIMARY KEY (id_categoria)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.categoria
    OWNER to postgres;
	
	


-- Cria a tabela Endereço.

CREATE TABLE IF NOT EXISTS public.endereco
(
    id_endereco integer NOT NULL DEFAULT nextval('endereco_id_endereco_seq'::regclass),
    rua character varying(50) COLLATE pg_catalog."default" NOT NULL,
    numero character varying(50) COLLATE pg_catalog."default",
    bairro character varying(50) COLLATE pg_catalog."default" NOT NULL,
    cidade character varying(50) COLLATE pg_catalog."default" NOT NULL,
    uf character varying(2) COLLATE pg_catalog."default" NOT NULL,
    cep character varying(10) COLLATE pg_catalog."default" NOT NULL,
    id_evento integer NOT NULL,
    CONSTRAINT endereco_pkey PRIMARY KEY (id_endereco)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.endereco
    OWNER to postgres;
	
	

-- Cria uma tabela evento.

CREATE TABLE IF NOT EXISTS public.evento
(
    id_evento integer NOT NULL DEFAULT nextval('evento_id_evento_seq'::regclass),
    nome_evento character varying(60) COLLATE pg_catalog."default" NOT NULL,
    datahora_evento character varying(20) COLLATE pg_catalog."default" NOT NULL,
    datahora_eventofinal character varying(20) COLLATE pg_catalog."default" NOT NULL,
    descricao character varying COLLATE pg_catalog."default" NOT NULL,
    status character varying(20) COLLATE pg_catalog."default",
    id_categoria integer NOT NULL,
    valor_ingresso numeric(10,2),
    limite_pessoas integer,
    CONSTRAINT evento_pkey PRIMARY KEY (id_evento),
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria)
        REFERENCES public.categoria (id_categoria) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.evento
    OWNER to postgres;
	
	
	
	

-- Cria uma tabela Ingresso.

CREATE TABLE IF NOT EXISTS public.ingresso
(
    ingresso_id integer NOT NULL DEFAULT nextval('ingresso_ingresso_id_seq'::regclass),
    evento_id integer NOT NULL,
    pessoa_id integer NOT NULL,
    valor_ingresso numeric(10,2) NOT NULL,
    tipo_ingresso character varying(50) COLLATE pg_catalog."default" NOT NULL,
    data_compra character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT ingresso_pkey PRIMARY KEY (ingresso_id),
    CONSTRAINT fk_evento FOREIGN KEY (evento_id)
        REFERENCES public.evento (id_evento) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_pessoa FOREIGN KEY (pessoa_id)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.ingresso
    OWNER to postgres;
	
	
	
	

-- Cria uma tabela pessoa.

CREATE TABLE IF NOT EXISTS public.pessoa
(
    id_pessoa integer NOT NULL DEFAULT nextval('pessoa_id_pessoa_seq'::regclass),
    nome character varying(60) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    senha character varying COLLATE pg_catalog."default" NOT NULL,
    telefone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    id_tipo_pessoa integer NOT NULL,
    CONSTRAINT pessoa_pkey PRIMARY KEY (id_pessoa),
    CONSTRAINT unique_email UNIQUE (email),
    CONSTRAINT fk_id_tipo_pessoa FOREIGN KEY (id_tipo_pessoa)
        REFERENCES public.tipo_pessoa (id_tipo_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pessoa
    OWNER to postgres;






-- Cria uma tabela pessoa física.

CREATE TABLE IF NOT EXISTS public.pessoa_fisica
(
    cpf character varying(12) COLLATE pg_catalog."default" NOT NULL,
    id_pessoa integer NOT NULL,
    datanascimento character varying(20) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (cpf),
    CONSTRAINT fk_pessoa_fisica FOREIGN KEY (id_pessoa)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pessoa_fisica
    OWNER to postgres;
	
	


-- Cria uma tabela pessoa jurídica

CREATE TABLE IF NOT EXISTS public.pessoa_juridica
(
    cnpj character varying(14) COLLATE pg_catalog."default" NOT NULL,
    id_pessoa integer NOT NULL,
    CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (cnpj),
    CONSTRAINT fk_pessoa_juridica FOREIGN KEY (id_pessoa)
        REFERENCES public.pessoa (id_pessoa) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.pessoa_juridica
    OWNER to postgres;
	
	
	


-- Cria uma tabela tipo pessoa

CREATE TABLE IF NOT EXISTS public.tipo_pessoa
(
    id_tipo_pessoa integer NOT NULL DEFAULT nextval('tipo_pessoa_id_tipo_pessoa_seq'::regclass),
    nome_tipo_pessoa character varying(50) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT tipo_pessoa_pkey PRIMARY KEY (id_tipo_pessoa)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.tipo_pessoa
    OWNER to postgres;