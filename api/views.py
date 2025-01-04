from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Activity, FitnessGoal, NotificationPreference
from .serializers import ActivitySerializer, FitnessGoalSerializer, NotificationPreferenceSerializer

class ActivityViewSet(viewsets.ModelViewSet):
    serializer_class = ActivitySerializer

    def get_queryset(self):
        return Activity.objects.filter(user=self.request.user)

    @action(detail=False, methods=['post'])
    def sync(self, request):
        # Handle offline sync
        activities = request.data.get('activities', [])
        created = []
        for activity_data in activities:
            activity_data['user'] = request.user.id
            serializer = self.get_serializer(data=activity_data)
            if serializer.is_valid():
                serializer.save()
                created.append(serializer.data)
        return Response({'created': created})

class FitnessGoalViewSet(viewsets.ModelViewSet):
    serializer_class = FitnessGoalSerializer

    def get_queryset(self):
        return FitnessGoal.objects.filter(user=self.request.user)

class NotificationPreferenceViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationPreferenceSerializer

    def get_queryset(self):
        return NotificationPreference.objects.filter(user=self.request.user)