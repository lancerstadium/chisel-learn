import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class CommTest extends AnyFlatSpec with ChiselScalatestTester {
    "Comm" should "pass" in {
        test(new Comm(2000, 80)) { dut =>
            dut.clock.setTimeout(0)
            for (i <- 0 until 4000) {
                dut.clock.step(1)
            }
        }
    }
}
