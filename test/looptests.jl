using ctrlBlocks
using Test
using ControlSystemsBase

@testset "loops" begin
    plant = PT1(1, 1)
    ctrl = P(2)
    @test minreal(openLoop(ctrl, plant)) == tf([2], [1, 1])
    @test minreal(closedLoop(ctrl, plant)) == tf([2], [1, 3])
    @test minreal(ctrlDisturbance(ctrl, plant)) == tf([1], [1, 3])
    @test minreal(outputDisturbance(ctrl, plant)) == tf([1, 1], [1, 3])
    @test minreal(errorSignal(ctrl, plant)) == tf([1, 1], [1, 3])
    @test minreal(controlOutput(ctrl, plant)) == tf([2, 2], [1, 3])
end