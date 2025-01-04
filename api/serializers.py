from rest_framework import serializers
from .models import Activity, FitnessGoal, NotificationPreference

class ActivitySerializer(serializers.ModelSerializer):
    class Meta:
        model = Activity
        fields = ['id', 'type', 'duration', 'distance', 'calories', 'created_at', 'sync_id']
        read_only_fields = ['id', 'created_at']

class FitnessGoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = FitnessGoal
        fields = ['id', 'type', 'target', 'start_date', 'end_date', 'completed']
        read_only_fields = ['id']

class NotificationPreferenceSerializer(serializers.ModelSerializer):
    class Meta:
        model = NotificationPreference
        fields = ['email_enabled', 'push_enabled', 'web_enabled', 'frequency']