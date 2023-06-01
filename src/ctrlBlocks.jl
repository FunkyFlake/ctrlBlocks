module ctrlBlocks

using Revise
using ControlSystemsBase

include("plants.jl")
include("controllers.jl")

export pi_ctrl
export P, PT1, PT2, I, IT1, PTn, ITn

end
