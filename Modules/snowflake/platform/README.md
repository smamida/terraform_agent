# Snowflake Platform

Creates a standard Snowflake database and an X-SMALL warehouse that starts suspended and auto-suspends after inactivity. The consumer root must configure the Snowflake provider using an approved authentication method; this module contains no credentials or provider configuration.

Snowflake warehouse use is billable. Set warehouse size and suspend behavior for the workload, and connect an account resource monitor/alerting policy before production use. This module is not called by the repository root.