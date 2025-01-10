from django.urls import path, include
from . import views
from .views import home_view
from django.contrib import admin
from .views import ActivityViewSet, FitnessGoalViewSet
from rest_framework.routers import DefaultRouter

# Set up the router for DRF viewsets
router = DefaultRouter()
router.register(r'activities', ActivityViewSet, basename='activity')
router.register(r'fitnessgoals', FitnessGoalViewSet, basename='fitnessgoal')

urlpatterns = [
    path('', views.home, name='home'),  # The homepage route
    path('admin/', admin.site.urls),  # This line is required to access the admin panel

    # API routes for activities using viewsets
    path('api/', include(router.urls)),  # Automatically creates endpoints for the viewset
]
