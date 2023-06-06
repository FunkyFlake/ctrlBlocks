using ctrlBlocks
using Test
using ControlSystemsBase

@testset "controllers" begin
    # PI
    @test PI(2, 3).tf == tf([2]) * tf([3, 1], [3, 0]) 
    @test PI_parallel(2,3).tf == tf([2]) + tf([3], [1, 0])

    # PDT
    @test PDT(2, 3, 4).tf == tf([2]) * tf([3, 1], [4, 1])
    @test PDT_parallel(2, 3, 4).tf == tf([2]) + tf([3, 0], [4, 1])
end