from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from .models import Activity, FitnessGoal
from .serializers import ActivitySerializer, FitnessGoalSerializer

# Define the index view (Static home page)
def home(request):
    return render(request, 'home.html')

# Define the home view (Rendering activities on a page)
def home_view(request):
    activities = Activity.objects.all()  # Get all activities from the database
    return render(request, 'fitness_tracker/home.html', {'activities': activities})

# Define the ActivityViewSet for API interactions
class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.all()  # Query all activities from the database
    serializer_class = ActivitySerializer  # Use the serializer class to convert data to JSON

    # You don't need to override the list method unless you want custom behavior.
    # The default `list` method provided by DRF will automatically serialize the data.
    
    # Optionally, you could override the `list` method if needed:
    # def list(self, request, *args, **kwargs):
    #     response = super().list(request, *args, **kwargs)
    #     return response

class FitnessGoalViewSet(viewsets.ModelViewSet):
    """
    A ViewSet for managing Fitness Goals.
    """
    queryset = FitnessGoal.objects.all()
    serializer_class = FitnessGoalSerializer

# If you want to handle a simple API endpoint for listing activities using an FBV, you can use:
@api_view(['GET'])
def activity_list(request):
    activities = Activity.objects.all()  # Get all activities
    serializer = ActivitySerializer(activities, many=True)
    return Response(serializer.data)  # Return the serialized activity data
