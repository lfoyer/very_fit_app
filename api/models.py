from django.db import models
from django.contrib.auth.models import User

class Activity(models.Model):
    ACTIVITY_TYPES = [
        ('RUN', 'Running'),
        ('BIKE', 'Cycling'),
        ('GYM', 'Workout'),
    ]
    
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    type = models.CharField(max_length=10, choices=ACTIVITY_TYPES)
    duration = models.IntegerField()  # in minutes
    distance = models.FloatField(null=True, blank=True)  # in kilometers
    calories = models.IntegerField()
    created_at = models.DateTimeField(auto_now_add=True)
    sync_id = models.CharField(max_length=100, unique=True)  # For offline sync

class FitnessGoal(models.Model):
    GOAL_TYPES = [
        ('FREQ', 'Frequency'),
        ('DIST', 'Distance'),
        ('CAL', 'Calories'),
    ]
    
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    type = models.CharField(max_length=10, choices=GOAL_TYPES)
    target = models.FloatField()
    start_date = models.DateField()
    end_date = models.DateField()
    completed = models.BooleanField(default=False)

class NotificationPreference(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    email_enabled = models.BooleanField(default=True)
    push_enabled = models.BooleanField(default=True)
    web_enabled = models.BooleanField(default=True)
    frequency = models.IntegerField(default=24)  # hours