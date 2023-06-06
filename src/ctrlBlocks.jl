module ctrlBlocks

using Revise
using ControlSystemsBase

include("plants.jl")
include("controllers.jl")

export pi_ctrl
export P, setK
export PT1, setK, setT 
export PT2, setK, setω, setD
export I, setKi
export IT1, setKi, setT 
export PTn, setK, setT
export ITn, setKi, setT

end
