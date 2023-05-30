using ctrlBlocks
using Test
using ControlSystemsBase

@testset "controllers" begin
    @test pi_ctrl(2, 1) == tf([2]) + tf([2], [1, 0])
    
    @test pi_ctrl(2, Ki=3) == tf([2]) + tf([3], [1, 0])
end