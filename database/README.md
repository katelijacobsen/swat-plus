# SWAT+ database (PostgreSQL)

Schema built from **"Database Diagram (1)"** in the FigJam board *Development Enviroments*.

| File | What it does |
|---|---|
| `01_schema.sql` | Creates all tables, keys, indexes and `updated_at` triggers. Drops and recreates SWAT+ tables, so it can be re-run. |
| `02_seed.sql` | Lookup data only: `status`, `roles`, `permissions`, `permissions_roles`, `competences`. No personal data. |

## Run it in DataGrip

1. Add a PostgreSQL data source (`localhost:5432`, user `postgres`).
2. Create the database: `CREATE DATABASE swat_plus;`
3. Switch the data source / console to `swat_plus`.
4. Right-click `01_schema.sql` → **Run**, then `02_seed.sql` → **Run**.

## Tables

- **Lookup:** `status`, `roles`, `permissions`, `competences`
- **Entities:** `users`, `shifts`, `bookings`, `queues`
- **Junction:** `permissions_roles`, `swat_tutor_competences`, `swat_tutor_shift`, `users_booking`

## Where it differs from the diagram

- `users.hashed_password` is `text`, not `varchar(12)` — a bcrypt/argon2 hash is 60–100 characters.
- `users.foreign_key` is left out — the diagram doesn't say what it points to.
- `shifts.status` and `bookings.status` are `status_fk` → `status`, matching the "One status can apply to many …" connectors.
- `users.uuid` uses `swat_uuid_v7()`, which works on PostgreSQL 13+ (PostgreSQL 18 also has a built-in `uuidv7()`).
- The Policies × Roles matrix has no ticks yet, so the `permissions_roles` seed follows the scenario text.
