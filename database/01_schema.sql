-- =====================================================================
-- SWAT+ — PostgreSQL schema
-- Built from "Database Diagram (1)" in the FigJam board
-- "Development Enviroments". Run on a fresh database (e.g. swat_plus).
-- Safe to re-run: it drops and recreates every SWAT+ object.
-- =====================================================================

BEGIN;

-- ---------------------------------------------------------------------
-- Clean slate (reverse dependency order)
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS users_booking          CASCADE;
DROP TABLE IF EXISTS queues                 CASCADE;
DROP TABLE IF EXISTS swat_tutor_shift       CASCADE;
DROP TABLE IF EXISTS swat_tutor_competences CASCADE;
DROP TABLE IF EXISTS bookings               CASCADE;
DROP TABLE IF EXISTS shifts                 CASCADE;
DROP TABLE IF EXISTS competences            CASCADE;
DROP TABLE IF EXISTS users                  CASCADE;
DROP TABLE IF EXISTS permissions_roles      CASCADE;
DROP TABLE IF EXISTS permissions            CASCADE;
DROP TABLE IF EXISTS roles                  CASCADE;
DROP TABLE IF EXISTS status                 CASCADE;

-- ---------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------

-- "uuid 7" from the diagram. PostgreSQL 18 has uuidv7() built in;
-- this function gives the same time-ordered UUIDv7 on PostgreSQL 13+.
CREATE OR REPLACE FUNCTION swat_uuid_v7() RETURNS uuid
LANGUAGE sql VOLATILE AS $$
  SELECT encode(
           set_bit(
             set_bit(
               overlay(uuid_send(gen_random_uuid())
                       PLACING substring(int8send(floor(extract(epoch FROM clock_timestamp()) * 1000)::bigint) FROM 3)
                       FROM 1 FOR 6),
               52, 1),
             53, 1),
           'hex')::uuid;
$$;

-- Keeps updated_at current on every UPDATE.
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger
LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at := now();
  RETURN NEW;
END;
$$;

-- ---------------------------------------------------------------------
-- Lookup tables
-- ---------------------------------------------------------------------

-- status: shared by shifts, bookings and queues
CREATE TABLE status (
  id    integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title varchar(20) NOT NULL UNIQUE
);

-- roles: admin, coordinator, student, lector, tutor
CREATE TABLE roles (
  id    integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title varchar(15) NOT NULL UNIQUE
);

-- permissions: what a role may do (edit shifts, swap shifts, ...)
CREATE TABLE permissions (
  id    integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title varchar(15) NOT NULL UNIQUE
);

-- Junction: one role has many permissions, one permission belongs to many roles
CREATE TABLE permissions_roles (
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  permission_fk integer NOT NULL REFERENCES permissions (id) ON DELETE CASCADE,
  role_fk       integer NOT NULL REFERENCES roles (id)       ON DELETE CASCADE,
  UNIQUE (permission_fk, role_fk)
);

-- competences: what a SWAT tutor can help with (Git, Figma, ...)
CREATE TABLE competences (
  id    integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  title varchar(20) NOT NULL UNIQUE
);

-- ---------------------------------------------------------------------
-- Entities
-- ---------------------------------------------------------------------

-- users: students, SWAT tutors, the coordinator, lecturers and the admin.
-- The role decides what each user can see and do, so moving the
-- coordinator role to another tutor is one UPDATE of user_type_fk and
-- keeps all of that user's rows.
CREATE TABLE users (
  id              integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  uuid            uuid        NOT NULL DEFAULT swat_uuid_v7() UNIQUE,
  user_type_fk    integer     NOT NULL REFERENCES roles (id),
  firstname       varchar(50) NOT NULL,
  lastname        varchar(50) NOT NULL,
  email           varchar(50) NOT NULL,
  hashed_password text        NOT NULL,  -- diagram says varchar(12); a bcrypt/argon2 hash is 60–100 chars
  mobile_number   varchar(8),
  created_at      timestamptz NOT NULL DEFAULT now(),
  updated_at      timestamptz NOT NULL DEFAULT now(),
  deleted_at      timestamptz             -- soft delete
);

-- Unique key on email (case-insensitive) among users who are not deleted
CREATE UNIQUE INDEX users_email_unique ON users (lower(email)) WHERE deleted_at IS NULL;
CREATE INDEX users_user_type_fk_idx ON users (user_type_fk);

CREATE TABLE shifts (
  id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  status_fk   integer     NOT NULL REFERENCES status (id),
  starting_at timestamptz NOT NULL,
  ending_at   timestamptz NOT NULL,
  created_at  timestamptz NOT NULL DEFAULT now(),
  updated_at  timestamptz NOT NULL DEFAULT now(),
  deleted_at  timestamptz,
  CONSTRAINT shifts_end_after_start CHECK (ending_at > starting_at)
);
CREATE INDEX shifts_starting_at_idx ON shifts (starting_at);

-- bookings: a lecturer books SWAT tutors for a class
CREATE TABLE bookings (
  id         integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  room       varchar(10),
  status_fk  integer     NOT NULL REFERENCES status (id),
  material   text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);

-- queues: one row each time a student joins the digital queue.
-- Two foreign keys to users: the student, and the tutor who helps (NULL until assigned).
CREATE TABLE queues (
  id                     integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  student_fk             integer      NOT NULL REFERENCES users (id),
  assigned_swat_tutor_fk integer      REFERENCES users (id),
  info                   varchar(200),
  status_fk              integer      NOT NULL REFERENCES status (id),
  created_at             timestamptz  NOT NULL DEFAULT now(),
  updated_at             timestamptz  NOT NULL DEFAULT now(),
  deleted_at             timestamptz
);
CREATE INDEX queues_student_fk_idx ON queues (student_fk);
CREATE INDEX queues_assigned_swat_tutor_fk_idx ON queues (assigned_swat_tutor_fk);
CREATE INDEX queues_status_fk_idx ON queues (status_fk);

-- ---------------------------------------------------------------------
-- Junction tables
-- ---------------------------------------------------------------------

-- One SWAT tutor has many competences; one competence is held by many tutors
CREATE TABLE swat_tutor_competences (
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  swat_tutor_fk integer NOT NULL REFERENCES users (id)       ON DELETE CASCADE,
  competence_fk integer NOT NULL REFERENCES competences (id) ON DELETE CASCADE,
  UNIQUE (swat_tutor_fk, competence_fk)
);

-- One SWAT tutor is assigned to many shifts; one shift has many tutors
CREATE TABLE swat_tutor_shift (
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  swat_tutor_fk integer NOT NULL REFERENCES users (id)  ON DELETE CASCADE,
  shift_fk      integer NOT NULL REFERENCES shifts (id) ON DELETE CASCADE,
  UNIQUE (swat_tutor_fk, shift_fk)
);
CREATE INDEX swat_tutor_shift_shift_fk_idx ON swat_tutor_shift (shift_fk);

-- Links a booking to the lecturer who made it, the SWAT tutor(s) and the shift
CREATE TABLE users_booking (
  id            integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  booking_fk    integer NOT NULL REFERENCES bookings (id) ON DELETE CASCADE,
  swat_tutor_fk integer NOT NULL REFERENCES users (id),
  shift_fk      integer NOT NULL REFERENCES shifts (id),
  lector_fk     integer NOT NULL REFERENCES users (id),
  UNIQUE (booking_fk, swat_tutor_fk)
);
CREATE INDEX users_booking_shift_fk_idx ON users_booking (shift_fk);
CREATE INDEX users_booking_lector_fk_idx ON users_booking (lector_fk);

-- ---------------------------------------------------------------------
-- updated_at triggers
-- ---------------------------------------------------------------------
CREATE TRIGGER users_set_updated_at    BEFORE UPDATE ON users    FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER shifts_set_updated_at   BEFORE UPDATE ON shifts   FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER bookings_set_updated_at BEFORE UPDATE ON bookings FOR EACH ROW EXECUTE FUNCTION set_updated_at();
CREATE TRIGGER queues_set_updated_at   BEFORE UPDATE ON queues   FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMIT;
