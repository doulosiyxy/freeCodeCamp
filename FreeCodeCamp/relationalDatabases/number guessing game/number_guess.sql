--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

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

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

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
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    guesses integer,
    user_id integer,
    game_id integer NOT NULL
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: user_info; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.user_info (
    user_id integer NOT NULL,
    name character varying(22)
);


ALTER TABLE public.user_info OWNER TO freecodecamp;

--
-- Name: user_info_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.user_info_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_info_user_id_seq OWNER TO freecodecamp;

--
-- Name: user_info_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.user_info_user_id_seq OWNED BY public.user_info.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: user_info user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_info ALTER COLUMN user_id SET DEFAULT nextval('public.user_info_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (23, 1, 1);
INSERT INTO public.games VALUES (10, 1, 2);
INSERT INTO public.games VALUES (4, 1, 3);
INSERT INTO public.games VALUES (5, 6, 4);
INSERT INTO public.games VALUES (530, 7, 5);
INSERT INTO public.games VALUES (598, 7, 6);
INSERT INTO public.games VALUES (582, 8, 7);
INSERT INTO public.games VALUES (682, 8, 8);
INSERT INTO public.games VALUES (950, 7, 9);
INSERT INTO public.games VALUES (159, 7, 10);
INSERT INTO public.games VALUES (78, 7, 11);
INSERT INTO public.games VALUES (908, 9, 12);
INSERT INTO public.games VALUES (515, 9, 13);
INSERT INTO public.games VALUES (155, 10, 14);
INSERT INTO public.games VALUES (340, 10, 15);
INSERT INTO public.games VALUES (707, 9, 16);
INSERT INTO public.games VALUES (814, 9, 17);
INSERT INTO public.games VALUES (960, 9, 18);
INSERT INTO public.games VALUES (568, 11, 19);
INSERT INTO public.games VALUES (66, 11, 20);
INSERT INTO public.games VALUES (418, 12, 21);
INSERT INTO public.games VALUES (555, 12, 22);
INSERT INTO public.games VALUES (405, 11, 23);
INSERT INTO public.games VALUES (265, 11, 24);
INSERT INTO public.games VALUES (246, 11, 25);
INSERT INTO public.games VALUES (82, 13, 26);
INSERT INTO public.games VALUES (725, 13, 27);
INSERT INTO public.games VALUES (803, 14, 28);
INSERT INTO public.games VALUES (788, 14, 29);
INSERT INTO public.games VALUES (74, 13, 30);
INSERT INTO public.games VALUES (319, 13, 31);
INSERT INTO public.games VALUES (755, 13, 32);


--
-- Data for Name: user_info; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.user_info VALUES (1, 'Jim');
INSERT INTO public.user_info VALUES (6, 'Joan');
INSERT INTO public.user_info VALUES (7, 'user_1676374585242');
INSERT INTO public.user_info VALUES (8, 'user_1676374585241');
INSERT INTO public.user_info VALUES (9, 'user_1676374650884');
INSERT INTO public.user_info VALUES (10, 'user_1676374650883');
INSERT INTO public.user_info VALUES (11, 'user_1676374705774');
INSERT INTO public.user_info VALUES (12, 'user_1676374705773');
INSERT INTO public.user_info VALUES (13, 'user_1676374741367');
INSERT INTO public.user_info VALUES (14, 'user_1676374741366');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 32, true);


--
-- Name: user_info_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.user_info_user_id_seq', 14, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: user_info user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_info
    ADD CONSTRAINT user_info_pkey PRIMARY KEY (user_id);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.user_info(user_id);


--
-- PostgreSQL database dump complete
--
