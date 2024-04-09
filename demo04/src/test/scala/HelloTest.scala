import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class HelloTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Hello"
    it should "pass" in {
        test(new Hello) { c =>
        c.clock.setTimeout(0)
        var ledStatus = BigInt(-1)
        println("Start the blinking LED")
        for (_ <- 0 until 100) {
            c.clock.step(10000)
            val ledNow = c.io.led.peek().litValue
            val s = if (ledNow == 0) "o" else "*"
            if (ledStatus != ledNow) {
            System.out.println(s)
            ledStatus = ledNow
            }
        }
            println("\nEnd the blinking LED")
        }
    }
}


class TickerTest extends AnyFlatSpec with ChiselScalatestTester with TickerTestFunc {
    "UpTicker 5" should "pass" in {
        test(new UpTicker(5)) { dut => testFn(dut, 5) }
    }
    "DownTicker 7" should "pass" in {
        test(new DownTicker(7)) { dut => testFn(dut, 7) }
    }
    "NerdTicker 11" should "pass" in {
        test(new NerdTicker(11)) { dut => testFn(dut, 11) }
    }
}

trait TickerTestFunc {
    def testFn[T <: Ticker](dut: T, n: Int) = {
        // -1 表示无tick
        var count = -1
        for (_ <- 0 to n*3) {
            if(count > 0)
                dut.io.tick.expect(false.B)
            else if (count == 0)
                dut.io.tick.expect(true.B)
            
            // 每个tick重置
            if (dut.io.tick.peek.litToBoolean)
                count = n-1
            else
                count -= 1
            dut.clock.step()
        }
    }
}
