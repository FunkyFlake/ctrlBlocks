# Compensation controller calculation
# Gcl: desired closed loop transfer function
# Gp: plant transfer function
compensation(Gcl::TransferFunction, Gp::TransferFunction; eps=1e-3) = minreal(Gcl / (1 - Gcl) / Gp, eps)
compensation(Gcl::SysTF, Gp::SysTF; eps=1e-3) = minreal(Gcl.tf / (1 - Gcl.tf) / Gp.tf, eps)

# Serial connection of identical PT1 plants as desired closed loop response
# α: inverse of PT1 time constant (frequency)
# r: number of PT1 plants 
# choose r > order(plant denominator) - order(plant numerator)
# choose α to have the desired response time
serialPT1(α, r::Integer) = PTn(1, [1/α for i ∈ 1:r])