from django.db import models

# Create your models here.

class Hero(models.Model):
    name = models.CharField(max_length=120)
    age = models.IntegerField(default=25)

    def __str__(self):
        return self.name + str(self.age)
