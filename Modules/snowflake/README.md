# Snowflake

Reusable Snowflake Terraform resources live under `platform/`. Configure authentication in the consuming root; see `examples/provider.tf.example` for a key-pair authentication shape. Never commit private keys or account credentials.

The module uses the official `snowflakedb/snowflake` provider and manages a database plus a small, auto-suspending warehouse. Add resource monitors, grants, schemas, and production-specific retention only after ownership and cost requirements are known.