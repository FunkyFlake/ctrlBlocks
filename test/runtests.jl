using ctrlBlocks
using Test
using ControlSystemsBase

@testset "ctrlBlocks.jl" begin
    pi_ctrl(1, 1)
    pi_ctrl(1, Ki=1)
    @test pi_ctrl(1, 1) == tf([1]) + tf([1], [1, 0])
end
