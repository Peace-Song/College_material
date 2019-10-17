from django.urls import path

from . import views


urlpatterns = [
    path('', views.hero_list),
    path("session/", views.index),
] 
