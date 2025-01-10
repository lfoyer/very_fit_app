# Projet CASI - INSA Rouen 2024-205

## Run the backend
Command to run the docker container:

```bash
docker-compose up --build
docker-compose exec web python manage.py migrate
```

The project will be available at `http://localhost:8000`

## Run the frontend
Command to run the mobile frontend :

```bash
flutter run
```
