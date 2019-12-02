class Product:
    def __init__(self, name='', price=0):
        self.name = name
        self._price = price
        self._observers = []
 
    def attach(self, observer):
        if observer not in self._observers:
            self._observers.append(observer)
    
    def notify(self, modifier=None):
        for observer in self._observers:
            if observer == 
 
    @property
    def price(self):
        return self._price
 
    @price.setter
    def price(self, value):
        self._price = value
        notify(PriceView)
        print("Bravo 6, going dark.")
        return


class PriceViewer:
    def update(self, product):
        print('PriceNotify: Product %s has price %d'
            % (product.name, product.price))

if __name__ == "__main__":
    product = Product('Macbook Pro', 3000)
    viewer = PriceViewer()
    product.attach(viewer)
    product.price = 2900
