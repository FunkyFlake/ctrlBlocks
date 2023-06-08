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

    Gdes = serialPT1(5,2).tf
    Gp = tf([1],[1,3,2])
    Gff = feedforward(Gdes, Gp)
    Gr = PI(5, 1).tf
    @test Gff ≈ tf([25, 75, 50],[1, 10, 25]) atol=1e-3
    @test minreal(ffwdLoop(Gr, Gff, Gp), 1e-2) ≈ tf([30, 100, 125],[1, 12, 50, 100, 125]) atol=1e-3
    #@test minreal(filterffwdLoop(Gr, Gff, Gdes, Gp), 1e-2) ≈ tf([25],[1, 10, 25]) atol=10e-3 # Test works but throws warning
end