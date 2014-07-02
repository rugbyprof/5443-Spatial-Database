--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: state_buildings; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_buildings (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(Polygon,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16)
);


ALTER TABLE public.state_buildings OWNER TO griffin;

--
-- Name: state_buildings_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_buildings_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_buildings_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_buildings_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_buildings_ogc_fid_seq OWNED BY state_buildings.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_buildings ALTER COLUMN ogc_fid SET DEFAULT nextval('state_buildings_ogc_fid_seq'::regclass);


--
-- Name: state_buildings_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_buildings
    ADD CONSTRAINT state_buildings_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_buildings_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_buildings_geom_idx ON state_buildings USING gist (wkb_geometry);

--
-- Name: state_landuse; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_landuse (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(Polygon,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16)
);


ALTER TABLE public.state_landuse OWNER TO griffin;

--
-- Name: state_landuse_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_landuse_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_landuse_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_landuse_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_landuse_ogc_fid_seq OWNED BY state_landuse.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_landuse ALTER COLUMN ogc_fid SET DEFAULT nextval('state_landuse_ogc_fid_seq'::regclass);


--
-- Name: state_landuse_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_landuse
    ADD CONSTRAINT state_landuse_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_landuse_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_landuse_geom_idx ON state_landuse USING gist (wkb_geometry);




--
-- Name: state_natural; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_natural (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(Polygon,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16)
);


ALTER TABLE public.state_natural OWNER TO griffin;

--
-- Name: state_natural_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_natural_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_natural_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_natural_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_natural_ogc_fid_seq OWNED BY state_natural.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_natural ALTER COLUMN ogc_fid SET DEFAULT nextval('state_natural_ogc_fid_seq'::regclass);


--
-- Name: state_natural_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_natural
    ADD CONSTRAINT state_natural_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_natural_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_natural_geom_idx ON state_natural USING gist (wkb_geometry);


--
-- PostgreSQL database dump complete
--
--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: state_places; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_places (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(Point,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16),
    population numeric(10,0)
);


ALTER TABLE public.state_places OWNER TO griffin;

--
-- Name: state_places_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_places_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_places_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_places_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_places_ogc_fid_seq OWNED BY state_places.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_places ALTER COLUMN ogc_fid SET DEFAULT nextval('state_places_ogc_fid_seq'::regclass);


--
-- Name: state_places_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_places
    ADD CONSTRAINT state_places_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_places_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_places_geom_idx ON state_places USING gist (wkb_geometry);


-- Name: state_points; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_points (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(Point,4326),
    osm_id character varying(11),
    "timestamp" character varying(20),
    name character varying(48),
    type character varying(16)
);


ALTER TABLE public.state_points OWNER TO griffin;

--
-- Name: state_points_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_points_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_points_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_points_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_points_ogc_fid_seq OWNED BY state_points.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_points ALTER COLUMN ogc_fid SET DEFAULT nextval('state_points_ogc_fid_seq'::regclass);


--
-- Name: state_points_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_points
    ADD CONSTRAINT state_points_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_points_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_points_geom_idx ON state_points USING gist (wkb_geometry);

--
-- Name: state_railways; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_railways (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(LineString,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16)
);


ALTER TABLE public.state_railways OWNER TO griffin;

--
-- Name: state_railways_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_railways_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_railways_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_railways_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_railways_ogc_fid_seq OWNED BY state_railways.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_railways ALTER COLUMN ogc_fid SET DEFAULT nextval('state_railways_ogc_fid_seq'::regclass);


--
-- Name: state_railways_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_railways
    ADD CONSTRAINT state_railways_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_railways_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_railways_geom_idx ON state_railways USING gist (wkb_geometry);

--
-- Name: state_roads; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_roads (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(LineString,4326),
    osm_id character varying(11),
    name character varying(48),
    ref character varying(16),
    type character varying(16),
    oneway numeric(1,0),
    bridge numeric(1,0),
    tunnel numeric(1,0),
    maxspeed numeric(3,0)
);


ALTER TABLE public.state_roads OWNER TO griffin;

--
-- Name: state_roads_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_roads_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_roads_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_roads_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_roads_ogc_fid_seq OWNED BY state_roads.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_roads ALTER COLUMN ogc_fid SET DEFAULT nextval('state_roads_ogc_fid_seq'::regclass);


--
-- Name: state_roads_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_roads
    ADD CONSTRAINT state_roads_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_roads_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_roads_geom_idx ON state_roads USING gist (wkb_geometry);

--
-- Name: state_waterways; Type: TABLE; Schema: public; Owner: griffin; Tablespace: 
--

CREATE TABLE state_waterways (
    ogc_fid integer NOT NULL,
    wkb_geometry geometry(LineString,4326),
    osm_id character varying(11),
    name character varying(48),
    type character varying(16),
    width numeric(3,0)
);


ALTER TABLE public.state_waterways OWNER TO griffin;

--
-- Name: state_waterways_ogc_fid_seq; Type: SEQUENCE; Schema: public; Owner: griffin
--

CREATE SEQUENCE state_waterways_ogc_fid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.state_waterways_ogc_fid_seq OWNER TO griffin;

--
-- Name: state_waterways_ogc_fid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: griffin
--

ALTER SEQUENCE state_waterways_ogc_fid_seq OWNED BY state_waterways.ogc_fid;


--
-- Name: ogc_fid; Type: DEFAULT; Schema: public; Owner: griffin
--

ALTER TABLE ONLY state_waterways ALTER COLUMN ogc_fid SET DEFAULT nextval('state_waterways_ogc_fid_seq'::regclass);


--
-- Name: state_waterways_pk; Type: CONSTRAINT; Schema: public; Owner: griffin; Tablespace: 
--

ALTER TABLE ONLY state_waterways
    ADD CONSTRAINT state_waterways_pk PRIMARY KEY (ogc_fid);


--
-- Name: state_waterways_geom_idx; Type: INDEX; Schema: public; Owner: griffin; Tablespace: 
--

CREATE INDEX state_waterways_geom_idx ON state_waterways USING gist (wkb_geometry);


--
-- PostgreSQL database dump complete
--
