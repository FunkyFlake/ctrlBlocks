# Standard PI controller: 
#G = Kp + Ki/s = Kp + Kp/(Tn*s) = Kp(1 + 1/(Tn*s)
# Kp (1 + Tn*s)
# -------------
#     Tn*s  
mutable struct PI
    Kp
    Tn
    tf::TransferFunction
end

PI(Kp, Tn) = PI(Kp, Tn, pi_tf(Kp, Tn))
pi_tf(Kp, Tn) = tf([Kp]) * tf([Tn, 1], [Tn, 0])

setKp!(ctrl::PI, Kp) = (ctrl.Kp = Kp; ctrl.tf = pi_tf(Kp, ctrl.Tn))
setTn!(ctrl::PI, Tn) = (ctrl.Tn = Tn; ctrl.tf = pi_tf(ctrl.Kp, Tn))

mutable struct PI_parallel
    Kp
    Ki
    tf::TransferFunction
end

PI_parallel(Kp, Ki) = PI_parallel(Kp, Ki, pi_parallel_tf(Kp, Ki))
pi_parallel_tf(Kp, Ki) = tf([Kp]) + tf([Ki], [1, 0])

setKp!(ctrl::PI_parallel, Kp) = (ctrl.Kp = Kp; ctrl.tf = pi_parallel_tf(Kp, ctrl.Ki))
setKi!(ctrl::PI_parallel, Ki) = (ctrl.Ki = Ki; ctrl.tf = pi_parallel_tf(ctrl.Kp, Ki))
############################################################################
# Standard PDT controller: 
#G = Kp + Kd*s/(Td*s+1) = Kp(1 + Tv*s)/(1 + Td*s)
# Kp (1 + Tn*s)
# -------------
#     Tn*s  
mutable struct PDT
    Kp
    Tv
    Td
    tf::TransferFunction
end

PDT(Kp, Tv, Td) = PDT(Kp, Tv, Td, pdt_tf(Kp, Tv, Td))
pdt_tf(Kp, Tv, Td) = tf([Kp]) * tf([Tv, 1], [Td, 1])

setKp!(ctrl::PDT, Kp) = (ctrl.Kp = Kp; ctrl.tf = pdt_tf(Kp, ctrl.Tv, ctrl.Td))
setTv!(ctrl::PDT, Tv) = (ctrl.Tv = Tv; ctrl.tf = pdt_tf(ctrl.Kp, Tv, ctrl.Td))
setTd!(ctrl::PDT, Td) = (ctrl.Td = Td; ctrl.tf = pdt_tf(ctrl.Kp, ctrl.Tv, Td))

mutable struct PDT_parallel
    Kp
    Kd
    Td
    tf::TransferFunction
end

PDT_parallel(Kp, Kd, Td) = PDT_parallel(Kp, Kd, Td, PDT_parallel_tf(Kp, Kd, Td))
PDT_parallel_tf(Kp, Kd, Td) = tf([Kp]) + tf([Kd, 0], [Td, 1])

setKp!(ctrl::PDT_parallel, Kp) = (ctrl.Kp = Kp; ctrl.tf = PDT_parallel_tf(Kp, ctrl.Kd, ctrl.Td))
setKd!(ctrl::PDT_parallel, Kd) = (ctrl.Kd = Kd; ctrl.tf = PDT_parallel_tf(ctrl.Kp, Kd, ctrl.Td))
setTd!(ctrl::PDT_parallel, Td) = (ctrl.Td = Td; ctrl.tf = PDT_parallel_tf(ctrl.Kp, ctrl.Kd, Td))
############################################################################
