module ctrlBlocks

using Revise
using ControlSystemsBase

include("plants.jl")
include("controllers.jl")

export pi_ctrl
export p, pt1

end
