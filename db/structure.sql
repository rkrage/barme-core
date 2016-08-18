--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: core; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA core;


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA core;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = core, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: beer_categories; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE beer_categories (
    beer_category_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    beer_category text NOT NULL
);


--
-- Name: beer_styles; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE beer_styles (
    beer_style_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name text NOT NULL,
    description text,
    external_id integer NOT NULL,
    beer_category_id uuid NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: beers; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE beers (
    beer_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    description text,
    abv numeric,
    ibu integer,
    label_icon character varying,
    label_medium character varying,
    label_large character varying,
    external_id character varying NOT NULL,
    beer_style_id uuid,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: oauth_access_grants; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_grants (
    oauth_access_grant_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    resource_owner_id uuid NOT NULL,
    application_id uuid NOT NULL,
    token character varying NOT NULL,
    expires_in integer NOT NULL,
    redirect_uri text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    revoked_at timestamp without time zone,
    scopes character varying
);


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE oauth_access_tokens (
    oauth_access_token_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    resource_owner_id uuid,
    application_id uuid,
    token character varying NOT NULL,
    refresh_token character varying,
    expires_in integer,
    revoked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    scopes character varying,
    previous_refresh_token character varying DEFAULT ''::character varying NOT NULL
);


--
-- Name: oauth_applications; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE oauth_applications (
    oauth_application_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    uid character varying NOT NULL,
    secret character varying NOT NULL,
    redirect_uri text NOT NULL,
    scopes character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: core; Owner: -; Tablespace: 
--

CREATE TABLE users (
    user_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


SET search_path = public, pg_catalog;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


SET search_path = core, pg_catalog;

--
-- Name: beer_categories_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY beer_categories
    ADD CONSTRAINT beer_categories_pkey PRIMARY KEY (beer_category_id);


--
-- Name: beer_styles_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY beer_styles
    ADD CONSTRAINT beer_styles_pkey PRIMARY KEY (beer_style_id);


--
-- Name: beers_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY beers
    ADD CONSTRAINT beers_pkey PRIMARY KEY (beer_id);


--
-- Name: oauth_access_grants_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT oauth_access_grants_pkey PRIMARY KEY (oauth_access_grant_id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (oauth_access_token_id);


--
-- Name: oauth_applications_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY oauth_applications
    ADD CONSTRAINT oauth_applications_pkey PRIMARY KEY (oauth_application_id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: core; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


SET search_path = public, pg_catalog;

--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


SET search_path = core, pg_catalog;

--
-- Name: index_beer_styles_on_beer_category_id; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE INDEX index_beer_styles_on_beer_category_id ON beer_styles USING btree (beer_category_id);


--
-- Name: index_beer_styles_on_external_id; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE INDEX index_beer_styles_on_external_id ON beer_styles USING btree (external_id);


--
-- Name: index_beers_on_beer_style_id; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE INDEX index_beers_on_beer_style_id ON beers USING btree (beer_style_id);


--
-- Name: index_beers_on_external_id; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE INDEX index_beers_on_external_id ON beers USING btree (external_id);


--
-- Name: index_oauth_access_grants_on_token; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_grants_on_token ON oauth_access_grants USING btree (token);


--
-- Name: index_oauth_access_tokens_on_refresh_token; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_refresh_token ON oauth_access_tokens USING btree (refresh_token);


--
-- Name: index_oauth_access_tokens_on_resource_owner_id; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE INDEX index_oauth_access_tokens_on_resource_owner_id ON oauth_access_tokens USING btree (resource_owner_id);


--
-- Name: index_oauth_access_tokens_on_token; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_access_tokens_on_token ON oauth_access_tokens USING btree (token);


--
-- Name: index_oauth_applications_on_uid; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_oauth_applications_on_uid ON oauth_applications USING btree (uid);


--
-- Name: index_users_on_email; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: core; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: fk_rails_11f662addb; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY beers
    ADD CONSTRAINT fk_rails_11f662addb FOREIGN KEY (beer_style_id) REFERENCES beer_styles(beer_style_id);


--
-- Name: fk_rails_49a14e1eff; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY beer_styles
    ADD CONSTRAINT fk_rails_49a14e1eff FOREIGN KEY (beer_category_id) REFERENCES beer_categories(beer_category_id);


--
-- Name: fk_rails_732cb83ab7; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT fk_rails_732cb83ab7 FOREIGN KEY (application_id) REFERENCES oauth_applications(oauth_application_id);


--
-- Name: fk_rails_b4b53e07b8; Type: FK CONSTRAINT; Schema: core; Owner: -
--

ALTER TABLE ONLY oauth_access_grants
    ADD CONSTRAINT fk_rails_b4b53e07b8 FOREIGN KEY (application_id) REFERENCES oauth_applications(oauth_application_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO core, public;

INSERT INTO schema_migrations (version) VALUES ('20160812215819'), ('20160812215939'), ('20160812235617'), ('20160817003121'), ('20160817024205'), ('20160817031519'), ('20160817031619');


