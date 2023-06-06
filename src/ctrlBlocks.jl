module ctrlBlocks

using Revise
using ControlSystemsBase

include("controllers.jl")
export PI, setKp!, setTn!
export PI_parallel, setKp!, setKi!

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

end
