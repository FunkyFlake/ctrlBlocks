using ctrlBlocks
using Test
using ControlSystemsBase

@testset "plants" begin
    @test p(4.2) == tf([4.2])
    @test pt1(2, 3) == tf([2], [3, 1])
end