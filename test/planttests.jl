using ctrlBlocks
using Test
using ControlSystemsBase

@testset "plants" begin
    @test pt1(2, 3) == tf([2], [3, 1])
end