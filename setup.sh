#!/bin/bash

echo "Starting Docker containers..."
docker-compose up -d

echo "Waiting for services to be ready..."
sleep 10

echo "Running migrations..."
docker-compose exec -T web python manage.py migrate

# Check if superuser credentials are provided as environment variables
if [ -z "$DJANGO_SUPERUSER_USERNAME" ] || [ -z "$DJANGO_SUPERUSER_EMAIL" ] || [ -z "$DJANGO_SUPERUSER_PASSWORD" ]; then
    echo "Creating superuser interactively..."
    docker-compose exec web python manage.py createsuperuser
else
    echo "Creating superuser with provided credentials..."
    docker-compose exec -T web python manage.py createsuperuser \
        --noinput \
        --username $DJANGO_SUPERUSER_USERNAME \
        --email $DJANGO_SUPERUSER_EMAIL
fi

echo "Setup complete! The server is running at http://localhost:8000"