# Database Migrations

This folder contains database migration scripts for `poka_ce`.

## Migration Strategy
Currently, `poka_ce` is in early development and has not yet been released. Therefore, the `schemaVersion` in `AppDatabase` should remain at `1`.

Any database schema changes (adding tables, adding columns) should be done directly in the table definition files in `lib/database/tables/` and the app should be reinstalled/cleared to reflect the changes during development. 

Once the app is released, we will start using `schemaVersion` > 1 and writing `onUpgrade` migrations here.
