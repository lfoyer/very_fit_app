from django.db import models
from django.contrib.auth.models import User

class Activity(models.Model):
    ACTIVITY_TYPES = [
        ('RUN', 'Running'),
        ('BIKE', 'Cycling'),
        ('GYM', 'Workout'),
    ]
    
    #user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='api_activities')  # Unique related_name
    type = models.CharField(max_length=10, choices=ACTIVITY_TYPES)
    duration = models.IntegerField()  # in minutes
    distance = models.FloatField(null=True, blank=True)  # in kilometers
    calories = models.IntegerField()
    #created_at = models.DateTimeField(auto_now_add=True)
    #sync_id = models.CharField(max_length=100, unique=True)  # For offline sync

class FitnessGoal(models.Model):
    GOAL_TYPES = [
        ('FREQ', 'Frequency'),
        ('DIST', 'Distance'),
        ('CAL', 'Calories'),
    ]
    
    type = models.CharField(max_length=10, choices=GOAL_TYPES)
    target = models.FloatField()
    start_date = models.DateField()
    end_date = models.DateField()
    completed = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.type} Goal for {self.user.username}"