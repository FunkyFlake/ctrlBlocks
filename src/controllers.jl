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
