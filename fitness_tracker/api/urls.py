from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ActivityViewSet, ActivityDeleteView, FitnessGoalViewSet

# Set up the router
router = DefaultRouter()
router.register(r'activities', ActivityViewSet)  # Automatically handles CRUD for activities
router.register(r'fitnessgoals', FitnessGoalViewSet)

urlpatterns = [
    path('', include(router.urls)),  # Include default router-generated activity routes
]
