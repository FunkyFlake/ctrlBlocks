using ctrlBlocks
using Test
using ControlSystemsBase

@testset "compensation" begin
    plant = PTn(2, [1.2, 0.5, 0.1]) # n-m = 3
    r = 3
    α = 2.1
    desired = serialPT1(α, r)
    ctrl = compensation(desired, plant)
    @test ctrl ≈ minreal(tf([0.5]) * tf([0.06, 0.77, 1.8, 1], [0.1106, 0.6912, 1.44, 0])) atol = 0.25
end