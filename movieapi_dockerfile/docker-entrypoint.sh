#!/bin/bash
set -eux

# si DB_DRIVER existe ou pas vide alors
if [ -n "$DB_DRIVER" ]; then
    echo "J'installe le driver $DB_DRIVER"
    pip install $DB_DRIVER --root-user-action=ignore
fi

uvicorn movieapi.main:app --host 0.0.0.0 --port 8000