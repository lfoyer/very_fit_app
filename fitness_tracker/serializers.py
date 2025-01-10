from rest_framework import serializers
from fitness_tracker.models import Activity, FitnessGoal

class ActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Activity
        fields = ['id', 'type', 'duration', 'calories', 'distance']  # Adjust according to your model's fields


class FitnessGoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = FitnessGoal
        fields = ['id', 'type', 'start_date', 'end_date', 'completed', 'target']