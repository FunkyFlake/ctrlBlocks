using ctrlBlocks
using Test
using ControlSystemsBase

@testset "controllers" begin
    @test PI(2, 3).tf == tf([2]) * tf([3, 1], [3, 0]) 
    @test PI_parallel(2,3).tf == tf([2]) + tf([3], [1, 0])
end