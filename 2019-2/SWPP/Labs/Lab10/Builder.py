class Builder:
    def build_floor(self):
        raise NotImplementedError
    def build_body(self):
        raise NotImplementedError
    def build_ceiling(self):
        raise NotImplementedError

class House(Builder):
    def build_floor(self):
        print
    def build_body(self):
        raise NotImplementedError
    def build_ceiling(self):
        raise NotImplementedError

   
