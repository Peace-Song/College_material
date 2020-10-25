import scala.annotation.tailrec
import scala.util.control.TailCalls._

object AnonymFuncTest {
    def main(args: Array[String]): Unit = {
        println("sum of x from 0 to 100   : " + sum((x) => x, 100))
        println("sum of x^2 from 0 to 100 : " + sum((x) => x*x, 100))
        println("sum of x^3 from 0 to 100 : " + sum((x) => x*x*x, 100))

        println("------------MAPREDUCE-------------")
        println("sum of x from 0 to 100   : " + sumMR((x) => x, 100))
        println("sum of x^2 from 0 to 100 : " + sumMR((x) => x*x, 100))
        println("sum of x^3 from 0 to 100 : " + sumMR((x) => x*x*x, 100))

        println("-------MAPREDUCE_HEAVYLOAD-------")
        println("sum of x from 0 to 100000   : " + sumMR((x) => x, 100000) + " (OVERFLOW, but stack-safe)")
        println("sum of x^2 from 0 to 100000 : " + sumMR((x) => x*x, 100000) + " (OVERFLOW, but stack-safe)")
        println("sum of x^3 from 0 to 100000 : " + sumMR((x) => x*x*x, 100000) + " (OVERFLOW, but stack-safe)")

        println("product of x from 1 to 10 : " + productMR(10))
        println("product of x from 1 to 15 : " + productMR(15))
        println("product of x from 1 to 30 : " + productMR(30) + " (OVERFLOW)")
        
    }

    def sum(f: Int => Int, num: Int): Int = {
        if (num == 0) 0
        else f(num) + sum(f, num - 1)
    }

    def mapReduce(reduce: (Int, Int) => Int, map: Int => Int, init: Int, start: Int, end: Int): Int = {
        @tailrec
        def helper(start: Int, end: Int, cont: Int => TailRec[Int]): Int = {
            if (start <= end) helper(start + 1, end, (r) => tailcall(cont(reduce(map(start), r))))
            else cont(init).result
        }

        helper(start, end, (r) => done(r))
    }

    def sumMR(f: Int => Int, num: Int): Int = mapReduce((x, y) => x + y, f, 0, 0, num)
    def productMR(num: Int): Int = mapReduce((x, y) => x * y, (x) => x, 1, 1, num)
}