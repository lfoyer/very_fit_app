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

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
        
class FitnessGoalViewSet(viewsets.ModelViewSet):
    serializer_class = FitnessGoalSerializer

    def get_queryset(self):
        return FitnessGoal.objects.filter(user=self.request.user)
    
    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
    
    @action(detail=False, methods=['post'])
    def sync(self, request):
        # Handle offline sync
        goals = request.data.get('goals', [])
        created = []
        for goal_data in goals:
            goal_data['user'] = request.user.id
            serializer = self.get_serializer(data=goal_data)
            if serializer.is_valid():
                serializer.save()
                created.append(serializer.data)
        return Response({'created': created})

class NotificationPreferenceViewSet(viewsets.ModelViewSet):
    serializer_class = NotificationPreferenceSerializer

    def get_queryset(self):
        return NotificationPreference.objects.filter(user=self.request.user)