import scala.util.control.TailCalls._

object TailCall {
    def main(args:Array[String]): Unit = {
        println("val: " + sum1(0, 100000).result)
    }

    def sum1(acc: Int, n: Int): TailRec[Int] = {
        if (n == 0) done(acc)
        else tailcall(sum2(acc + n, n - 1))
    }

    def sum2(acc: Int, n: Int): TailRec[Int] = {
        if (n == 0) done(acc)
        else tailcall(sum1(acc + n, n - 1))
    }
}