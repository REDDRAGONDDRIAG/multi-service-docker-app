--
-- PostgreSQL database dump
--

\restrict dTwztYLMMjqAb8VOiAeauQD3hd9MZJiUcxV6bkQCBDNK6wdxlMnzFcikMysmuPF

-- Dumped from database version 15.17
-- Dumped by pg_dump version 15.17

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: devops
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    user_id integer,
    total numeric(10,2),
    status character varying(50) DEFAULT 'pending'::character varying
);


ALTER TABLE public.orders OWNER TO devops;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: devops
--

CREATE SEQUENCE public.orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_id_seq OWNER TO devops;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devops
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: devops
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(255),
    description text,
    price numeric(10,2),
    stock integer DEFAULT 0
);


ALTER TABLE public.products OWNER TO devops;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: devops
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_id_seq OWNER TO devops;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devops
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: devops
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(255),
    email character varying(255),
    password_hash character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO devops;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: devops
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO devops;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: devops
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: devops
--

COPY public.orders (id, user_id, total, status) FROM stdin;
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: devops
--

COPY public.products (id, name, description, price, stock) FROM stdin;
1	DevOps Course	Mastery	99.99	100
2	Kubernetes	Production	49.99	50
3	Docker Guide	Deep dive	79.99	75
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: devops
--

COPY public.users (id, username, email, password_hash, created_at) FROM stdin;
1	testuser	test@example.com	hash123	2026-04-28 18:07:23.360945
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devops
--

SELECT pg_catalog.setval('public.orders_id_seq', 1, false);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devops
--

SELECT pg_catalog.setval('public.products_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: devops
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: devops
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict dTwztYLMMjqAb8VOiAeauQD3hd9MZJiUcxV6bkQCBDNK6wdxlMnzFcikMysmuPF

