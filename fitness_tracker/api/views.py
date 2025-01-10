from rest_framework import viewsets
from .models import Activity, FitnessGoal
from .serializers import ActivitySerializer, FitnessGoalSerializer
from django.http import JsonResponse
from django.views import View

class ActivityViewSet(viewsets.ModelViewSet):
    queryset = Activity.objects.all()
    serializer_class = ActivitySerializer

    def destroy(self, request, *args, **kwargs):
        # The destroy method will handle the deletion
        return super().destroy(request, *args, **kwargs)

class FitnessGoalViewSet(viewsets.ModelViewSet):
    queryset = FitnessGoal.objects.all()
    serializer_class = FitnessGoalSerializer

    # Optionally filter by user if needed
    def get_queryset(self):
        user = self.request.user
        return FitnessGoal.objects.filter(user=user)

class ActivityDeleteView(View):
    def delete(self, request, pk):
        try:
            activity = Activity.objects.get(pk=pk)
            activity.delete()
            return JsonResponse({'message': 'Activity deleted successfully'}, status=204)
        except Activity.DoesNotExist:
            return JsonResponse({'message': 'Activity not found'}, status=404)