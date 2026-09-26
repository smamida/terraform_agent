# Lambda

`main.tf` is a starter Lambda function using a prebuilt ZIP, an externally managed least-privilege role, bounded memory/timeout, and a retained log group. Specify runtime, package path, networking, concurrency, and secret access before use. This module is not called by the repository root.