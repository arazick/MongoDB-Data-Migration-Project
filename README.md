# MongoDB Data Modeling & Migration

A MongoDB database for a workshop registration system, covering schema design,
an automated migration from Oracle SQL, integrity validation, and query
development.

## Overview

- Designed and implemented a MongoDB database for a workshop registration
  system, including schema design, data migration, and query development.
- Evaluated embedding vs. referencing strategies and selected a normalized
  two-collection schema for query flexibility and maintainability.
- Automated migration of workshop and registration data from Oracle SQL to
  MongoDB using a code-generation approach.
- Verified migration accuracy through document-count checks against the source data.
- Developed aggregation pipelines for registration reporting, capacity tracking,
  and conditional filtering.

## Schema design

The data is modeled as two collections linked by reference rather than embedding:

- `workshops` — one document per workshop (title, category, date, location,
  capacity)
- `registrations` — one document per registration, referencing its workshop by
  `WorkshopID`

Registrations are kept in their own collection rather than embedded inside
workshop documents so they can grow independently — a popular workshop's
registrations won't bloat the workshop record, and registrations can be queried
and aggregated on their own.

## How the migration works

Rather than moving data directly, this project uses a code-generation approach:
a SQL script reads the Oracle data and emits ready-to-run MongoDB insert
statements, which are then executed in MongoDB.

## Running it

**1. Set up the source data (Oracle SQL)**

- `sql/workshops_registrations.sql` – creates and populates the Oracle
  `Workshops` and `Registrations` tables.

**2. Generate the MongoDB migration script**

Run `sql/migration.sql` against the Oracle database with spooling enabled. It
queries both tables and outputs a MongoDB insert statement for each row,
producing `migration.js`:

```sql
SPOOL migration.js
@migration.sql
SPOOL OFF
```

**3. Load the data into MongoDB**

Run the generated script in the MongoDB shell against a running instance:

```bash
mongosh < mongodb/migration.js
```

`mongodb/Commands & Queries.txt` contains the aggregation pipelines used for
registration reporting, capacity tracking, and conditional filtering.

## Repository structure

- `sql/` – Oracle database scripts
  - `workshops_registrations.sql` – creates and populates the source tables
  - `migration.sql` – generates the MongoDB insert script from the Oracle data
- `mongodb/` – migration output and queries
  - `migration.js` – generated MongoDB insert statements
  - `Commands & Queries.txt` – aggregation pipelines and queries
- `report/` – project report with schema design, migration methodology, and
  implementation details
