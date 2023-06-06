using ctrlBlocks
using Test
using ControlSystemsBase

@testset "plants" begin
    ### P
    R = P(4.2)
    @test R.tf == tf([4.2])
    setK(R, 1)
    @test R.tf == tf([1])
    ### PT1
    R = PT1(2, 3)
    @test R.tf == tf([2], [3, 1])
    setK(R, 1)
    @test R.tf == tf([1], [3, 1])
    setT(R, 4)
    @test R.tf == tf([1], [4, 1])

    ### PT2
    R = PT2(2, 3, 4.)
    @test R.tf == tf([2], [1/3^2, 2*4/3, 1])
    setK(R, 1)
    @test R.tf == tf([1], [1/3^2, 2*4/3, 1])
    setω(R, 5)
    @test R.tf == tf([1], [1/5^2, 2*4/5, 1])
    setD(R, 6)
    @test R.tf == tf([1], [1/5^2, 2*6/5, 1])

    ### I
    R = I(2)
    @test R.tf == tf([2], [1, 0])
    setKi(R, 1)
    @test R.tf == tf([1], [1, 0])

    ### IT1
    R = IT1(2, 3)
    @test R.tf == tf([2], [3, 1, 0])
    setKi(R, 1)
    @test R.tf == tf([1], [3, 1, 0])
    setT(R, 4)
    @test R.tf == tf([1], [4, 1, 0])

    ### PTn
    R = PTn(2, [3, 4])
    @test R.tf == tf([2], [3, 1]) * tf([1], [4, 1])
    setK(R, 1)
    @test R.tf == tf([1], [3, 1]) * tf([1], [4, 1])
    setT(R, [5, 6])
    @test R.tf == tf([1], [5, 1]) * tf([1], [6, 1])

    ### ITn
    R = ITn(2, [3, 4])
    @test R.tf == tf([2],[1,0]) * tf([1], [3, 1]) * tf([1], [4, 1])
    setKi(R, 1)
    @test R.tf == tf([1],[1,0]) * tf([1], [3, 1]) * tf([1], [4, 1])
    setT(R, [5, 6])
    @test R.tf == tf([1],[1,0]) * tf([1], [5, 1]) * tf([1], [6, 1])
end