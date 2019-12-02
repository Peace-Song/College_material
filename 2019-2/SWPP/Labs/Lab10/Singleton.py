class Singleton:
    class _Singleton:
        def __init__(self, value):
            self.value = value

    _instance = None
    @staticmethod
    def get_instance():
        if Singleton._instance is None:
            Singleton()
        return Singleton._instance

    def __getattr__(self, name):
        return getattr(Singleton._instance, name)
    def __init__(self, value=0):
        _instance = _Singleton(value)


if __name__ == "__main__":
        s1 = Singleton(10)
        print(s1.value)
        print(Singleton.get_instance())
        s2 = Singleton(20)
        print(s2.value)
        print(s1.value)
        print(Singleton.get_instance())

