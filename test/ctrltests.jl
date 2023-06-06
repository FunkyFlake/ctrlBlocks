using ctrlBlocks
using Test
using ControlSystemsBase

@testset "controllers" begin
    # PI
    R = PI(2, 3)
    @test R.tf == tf([2]) * tf([3, 1], [3, 0]) 
    setKp!(R, 4)
    @test R.tf == tf([4]) * tf([3, 1], [3, 0])
    setTn!(R, 5)
    @test R.tf == tf([4]) * tf([5, 1], [5, 0])
    
    R= PI_parallel(2,3)
    @test R.tf == tf([2]) + tf([3], [1, 0])
    setKp!(R, 4)
    @test R.tf == tf([4]) + tf([3], [1, 0])
    setKi!(R, 5)
    @test R.tf == tf([4]) + tf([5], [1, 0])

    # PDT
    R = PDT(2, 3, 4)
    @test R.tf == tf([2]) * tf([3, 1], [4, 1])
    setKp!(R, 5)
    @test R.tf == tf([5]) * tf([3, 1], [4, 1])
    setTv!(R, 6)
    @test R.tf == tf([5]) * tf([6, 1], [4, 1])
    setTd!(R, 7)
    @test R.tf == tf([5]) * tf([6, 1], [7, 1])

    R = PDT_parallel(2, 3, 4)
    @test R.tf == tf([2]) + tf([3, 0], [4, 1])
    setKp!(R, 5)
    @test R.tf == tf([5]) + tf([3, 0], [4, 1])
    setKd!(R, 6)
    @test R.tf == tf([5]) + tf([6, 0], [4, 1])
    setTd!(R, 7)
    @test R.tf == tf([5]) + tf([6, 0], [7, 1])

    # PIDT
    R = PIDT(2, 3, 4, 5)
    @test R.tf == tf([2]) * tf([3*4, 3+4, 1], [3*5, 3, 0])
    setKp!(R, 6)
    @test R.tf == tf([6]) * tf([3*4, 3+4, 1], [3*5, 3, 0])
    setTn!(R, 7)
    @test R.tf == tf([6]) * tf([7*4, 7+4, 1], [7*5, 7, 0])
    setTv!(R, 8)
    @test R.tf == tf([6]) * tf([7*8, 7+8, 1], [7*5, 7, 0])
    setTd!(R, 9)
    @test R.tf == tf([6]) * tf([7*8, 7+8, 1], [7*9, 7, 0])

    R = PIDT_parallel(2, 3, 4, 5)
    @test R.tf == tf([2]) + tf([3], [1, 0]) + tf([4, 0], [5, 1])
    setKp!(R, 6)
    @test R.tf == tf([6]) + tf([3], [1, 0]) + tf([4, 0], [5, 1])
    setKd!(R, 7)
    @test R.tf == tf([6]) + tf([3], [1, 0]) + tf([7, 0], [5, 1])
    setTd!(R, 8)
    @test R.tf == tf([6]) + tf([3], [1, 0]) + tf([7, 0], [8, 1])
    setKi!(R, 9)
    @test R.tf == tf([6]) + tf([9], [1, 0]) + tf([7, 0], [8, 1])
end