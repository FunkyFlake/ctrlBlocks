## Simple closed control loop
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
openLoop(Gr::SysTF, Gp::SysTF) = Gr.tf * Gp.tf
############################################################################
# w to x, no TF in feedback
closedLoop(Gr::TransferFunction, Gp::TransferFunction) = Gr * Gp / (1 + Gr * Gp)
closedLoop(Gr::SysTF, Gp::SysTF) = Gr.tf * Gp.tf / (1 + Gr.tf * Gp.tf)
############################################################################
# z1 to x
ctrlDisturbance(Gr::TransferFunction, Gp::TransferFunction) = Gp / (1 + Gr * Gp)
ctrlDisturbance(Gr::SysTF, Gp::SysTF) = Gp.tf / (1 + Gr.tf * Gp.tf)
############################################################################
# z3 to x
outputDisturbance(Gr::TransferFunction, Gp::TransferFunction) = 1 / (1 + Gr * Gp)
outputDisturbance(Gr::SysTF, Gp::SysTF) =  1 / (1 + Gr.tf * Gp.tf)
############################################################################
# w to e
errorSignal(Gr::TransferFunction, Gp::TransferFunction) = 1 / (1 + Gr * Gp)
errorSignal(Gr::SysTF, Gp::SysTF) = 1 / (1 + Gr.tf * Gp.tf)
############################################################################
# w to y
controlOutput(Gr::TransferFunction, Gp::TransferFunction) = Gr / (1 + Gr * Gp)
controlOutput(Gr::SysTF, Gp::SysTF) = Gr.tf / (1 + Gr.tf * Gp.tf)
############################################################################
############################################################################
## Loop with feedforward and no input filter
# w to x with feedforward
ffwdLoop(Gr::TransferFunction, Gff::TransferFunction, Gp::TransferFunction) = Gp * (Gff + Gr) / (1 + Gr * Gp)
ffwdLoop(Gr::SysTF, Gff::SysTF, Gp::SysTF) = Gp.tf * (Gff.tf + Gr.tf) / (1 + Gr.tf * Gp.tf)
############################################################################