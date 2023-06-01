using ctrlBlocks
using Test
using ControlSystemsBase

@testset "plants" begin
    @test P(4.2).tf == tf([4.2])
    @test PT1(2, 3).tf == tf([2], [3, 1])
    @test PT2(2, 3, 4.).tf == tf([2], [1/3^2, 2*4/3, 1])
    @test I(2).tf == tf([2.], [1, 0.])
    @test PTn(2,[3,4]).tf == PT1(2,3).tf * PT1(1,4).tf
    @test ITn(2,[3]).tf == IT1(2,3).tf
end