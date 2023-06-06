# Simple closed control loop
# w: input 
# y: control output 
# x: controlled variable 
# f: feedback signal 
# e: error signal
# z1: disturbance before plant
# z2: disturbance withing plant
# z3: disturbance after plant
# Gr: controller transfer function
# Gp: plant transfer function
############################################################################
# w to x, no feedback
openLoop(Gr::TransferFunction, Gp::TransferFunction) = Gr * Gp
openLoop(Gr::Plant, Gp::Plant) = Gr.tf * Gp.tf
############################################################################
# w to x, no TF in feedback
closedLoop(Gr::TransferFunction, Gp::TransferFunction) = Gr * Gp / (1 + Gr * Gp)
closedLoop(Gr::Plant, Gp::Plant) = Gr.tf * Gp.tf / (1 + Gr.tf * Gp.tf)
############################################################################
# z1 to x
ctrlDisturbance(Gr::TransferFunction, Gp::TransferFunction) = Gp / (1 + Gr * Gp)
ctrlDisturbance(Gr::Plant, Gp::Plant) = Gp.tf / (1 + Gr.tf * Gp.tf)
############################################################################
# z3 to x
outputDisturbance(Gr::TransferFunction, Gp::TransferFunction) = 1 / (1 + Gr * Gp)
outputDisturbance(Gr::Plant, Gp::Plant) =  1 / (1 + Gr.tf * Gp.tf)
############################################################################
# w to e
errorSignal(Gr::TransferFunction, Gp::TransferFunction) = 1 / (1 + Gr * Gp)
errorSignal(Gr::Plant, Gp::Plant) = 1 / (1 + Gr.tf * Gp.tf)
############################################################################
# w to y
controlOutput(Gr::TransferFunction, Gp::TransferFunction) = Gr / (1 + Gr * Gp)
controlOutput(Gr::Plant, Gp::Plant) = Gr.tf / (1 + Gr.tf * Gp.tf)
############################################################################