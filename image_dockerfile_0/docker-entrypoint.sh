#!/bin/bash

# sequence specifique du ENTRYPOINT (obligatoire)
echo "Commande: $0 $*"
echo "Host: $DB_HOST"
echo "Port: $DB_PORT"
echo "Database: $DB_DATABASE"
echo "User: $DB_USER"
echo "Password length: ${#DB_PASSWORD}"

# sequence substituable de CMD
$*