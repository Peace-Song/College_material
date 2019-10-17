from django.test import TestCase, Client
from .models import Hero
# Create your tests here.

class HeroTestCase(TestCase):
    def setUp(self):
        Hero.objects.create(name="Superman")
        Hero.objects.create(name="Batman")
        Hero.objects.create(name="Ironman")
        
    def tearDown(self):
        pass

    def test_hero_count(self):
        self.assertEqual(Hero.objects.all().count(), 3)

    def test_hero(self):
        client = Client()
        response = client.get("/hero/")
        response1 = client.get("/hero/")

        self.assertIn("1", response.content.decode())
        self.assertIn("2", response1.content.decode())
