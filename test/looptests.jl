using ctrlBlocks
using Test
using ControlSystemsBase

@testset "loops" begin
    plant = PT1(1, 1)
    ctrl = P(2)
    @test minreal(openLoop(ctrl, plant)) == tf([2], [1, 1])
    @test minreal(closedLoop(ctrl, plant)) == tf([2], [1, 3])
end