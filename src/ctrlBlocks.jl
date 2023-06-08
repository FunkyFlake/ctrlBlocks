module ctrlBlocks

using Revise
using ControlSystemsBase

abstract type SysTF end

include("controllers.jl")
export PI, setKp!, setTn!
export PI_parallel, setKp!, setKi!
export PDT, setKp!, setTv!, setTd!
export PDT_parallel, setKp!, setKd!, setTd!
export PIDT, setKp!, setTv!, setTd!, setTn!
export PIDT_parallel, setKp!, setKd!, setTd!, setTn!

include("plants.jl")
export P, setK!
export PT1, setK!, setT!
export PT2, setK!, setω!, setD!
export I, setK!
export IT1, setK!, setT! 
export PTn, setK!, setT!
export ITn, setK!, setT!
export Tt, setTau!
export Dt1, setK!, setT!
export DTn, setK!, setT!
export AP1, setK!, setT!
export APn, setK!, setT!

include("loops.jl")
export openLoop, closedLoop
export ctrlDisturbance, outputDisturbance, errorSignal, controlOutput
export ffwdLoop

include("compensation.jl")
export compensation, serialPT1

include("feedforward.jl")
export feedforward
export filterStatic
export filterPT1, filterRamp, filterSqSine

end
