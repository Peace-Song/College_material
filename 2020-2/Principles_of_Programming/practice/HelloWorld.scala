object HelloWorld {
    def main(args:Array[String]): Unit = {
        println("Hello, World!")
        
        if (true || (loop == 1)) println("true") else println("false")
        println("sqrt(2): " + sqrt(2))
    }

    def one(x: Int, y: =>Int): Int = 1
    def loop: Int = loop

    def shouldTerminate(guess: Double, x: Double): Boolean = {
        guess * guess <= 1.001 * x && guess * guess >= 0.999 * x
    }
    def improve(guess: Double, x: Double): Double = (guess + x / guess) / 2
    def sqrtIter(guess: Double, x: Double): Double = {
        if (shouldTerminate(guess, x)) guess
        else sqrtIter(improve(guess, x), x)
    }
    def sqrt(x: Double): Double = sqrtIter(1, x)

}
