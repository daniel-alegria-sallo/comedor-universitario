#!/usr/bin/env bash
# Source: https:///sqlback.com/blog/complete-guide-to-sql-server-backup-and-restore-using-the-command-line
set -e
sqlcmd -S localhost -U sa -C -Q ":r ResetAll.sql"

