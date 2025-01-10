from django.shortcuts import render
from .models import Activity  # Example model for activities

# Home page view
def home(request):
    return render(request, 'home.html')

# Dashboard page view
def dashboard(request):
    # Example: Fetch user-specific data for the dashboard
    activities = Activity.objects.filter(user=request.user)
    return render(request, 'dashboard.html', {'activities': activities})

# Login page view
def login_view(request):
    return render(request, 'login.html')

# Registration page view
def register(request):
    return render(request, 'register.html')
