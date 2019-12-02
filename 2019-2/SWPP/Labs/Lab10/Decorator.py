def args_printer(func):
    print("d" + args)
    print("d" + kwargs)
    return func

@args_printer
def func1(x, y):
    pass

@args_printer
def func2(x, y, keyword="something"):
    pass

if __name__ == "__main__":
 func1(1, 3)
 func2("hello", "world", keyword="swpp")
