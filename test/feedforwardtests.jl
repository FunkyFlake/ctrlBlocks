using ctrlBlocks
using Test
using ControlSystemsBase

@testset "feedforward" begin
    plant = PT1(0.1, 1)
    ctrl = P(2)
    Gcl = closedLoop(ctrl, plant)
    @test filterStatic(Gcl) ≈ tf([6])

    ref = 2
    t = 0:0.1:10
    τ = 1
    w = filterPT1(ref, t, τ)
    @test w == ref * (1 .- exp.(-t/τ))
   
    Tend = 5
    w = filterRamp(ref, t, Tend)
    @test w == ref * min.(1, t ./ Tend)

    w = filterSqSine(ref, t, Tend)
    @test w == ref * sin.(π/2 * min.(1, t ./ Tend)).^2
end