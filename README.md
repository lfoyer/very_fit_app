# Informations for the project

## Run the backend

Command to run the docker container:

```bash
docker-compose up --build
docker-compose exec web python manage.py migrate
```

The project will be available at `http://localhost:8000`

## Run the frontend

Command to run the frontend:

```bash
flutter run
```

## By hand commands to create and fecth activities:
(once the docker server is running)
To list:

```bash
curl -H "Authorization: Token 24bc9d1709361fe6777d3512ec1dc33969bfb51d" http://localhost:8000/api/activities/ 
```

With the token above being the one of root user.

And to create a new activity:

```bash
curl -X POST http://localhost:8000/api/activities/ \                                                         
-H "Authorization: Token 24bc9d1709361fe6777d3512ec1dc33969bfb51d" \
-H "Content-Type: application/json" \
-d '{"type":"RUN", "duration":123, "distance":2.3, "calories":500, "sync_id":"test124"}'
```

For goals:
To list: 

```bash
curl -H "Authorization: Token 24bc9d1709361fe6777d3512ec1dc33969bfb51d" http://localhost:8000/api/goals/
```

To create: 

```bash
curl -X POST http://localhost:8000/api/goals/ \                                                         
-H "Authorization: Token 24bc9d1709361fe6777d3512ec1dc33969bfb51d" \
-H "Content-Type: application/json" \
-d '{"type":"FREQ", "target":5.0, "start_date":"2025-01-04", "end_date":"2025-02-04"}'
```
