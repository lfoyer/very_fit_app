# models.py

from django.db import models
from django.contrib.auth.models import User

class Activity(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField()
    duration = models.IntegerField()  # duration in minutes
    calories_burned = models.FloatField()

    def __str__(self):
        return self.name


class FitnessGoal(models.Model):
    goal_name = models.CharField(max_length=100)
    target_value = models.FloatField()
    current_value = models.FloatField()

    def __str__(self):
        return self.goal_name


class NotificationPreference(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    receive_notifications = models.BooleanField(default=True)

    def __str__(self):
        return f"Notifications for {self.user.username}"
