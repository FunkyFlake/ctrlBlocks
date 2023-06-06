# Simple closed control loop
# w: input 
# y: control output 
# x: controlled variable 
# f: feedback signal 
# e: error signal
# z1: disturbance before plant (acting with negative sign)
# z2: disturbance withing plant (acting with negative sign)
# z3: disturbance after plant (acting with negative sign)
# Gr: controller transfer function
# Gp: plant transfer function

function openLoop(Gr::TransferFunction, Gp::TransferFunction)
    return Gr * Gp
end

function closedLoop(Gr::TransferFunction, Gp::TransferFunction)
    return Gr * Gp / (1 + Gr * Gp)
end

function openLoop(Gr::Plant, Gp::Plant)
    return Gr.tf * Gp.tf
end

function closedLoop(Gr::Plant, Gp::Plant)
    return Gr.tf * Gp.tf / (1 + Gr.tf * Gp.tf)
end

