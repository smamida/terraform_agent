# dbt Snowflake Project

This is a starter dbt project, separate from Terraform infrastructure. It includes a sample model, dbt project config, and a profile template that reads account details and the key path from environment variables.

Use a stable Python 3.12 installation; the system currently has Python 3.15.0 beta, which is not a good base for this environment. From PowerShell, create and activate a project-local virtual environment, then install the adapter:

```powershell
py -3.12 -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

Configure the Snowflake variables in the current shell, then copy `profiles.yml.example` to `$HOME\.dbt\profiles.yml`. Keep the private key outside the repository and never commit the populated profile.

```powershell
New-Item -ItemType Directory -Force "$HOME\.dbt" | Out-Null
Copy-Item .\profiles.yml.example "$HOME\.dbt\profiles.yml"
$env:SNOWFLAKE_ACCOUNT = "<account_identifier>"
$env:SNOWFLAKE_USER = "<service_user>"
$env:SNOWFLAKE_ROLE = "<least_privilege_role>"
$env:SNOWFLAKE_DATABASE = "<database>"
$env:SNOWFLAKE_WAREHOUSE = "<warehouse>"
$env:SNOWFLAKE_SCHEMA = "<schema>"
$env:SNOWFLAKE_PRIVATE_KEY_PATH = "C:\secure\snowflake_key.p8"
```

Run project-only parsing first:

```powershell
dbt --version
dbt parse
```

After the profile and Snowflake connectivity are configured, check the connection with `dbt debug`. `dbt run --target dev` executes models and creates/updates Snowflake objects, so review the target account, database, schema, role, and warehouse before running it.