abstract type Controller <: SysTF end

# Standard PI controller: 
#G = Kp + Ki/s = Kp + Kp/(Tn*s) = Kp(1 + 1/(Tn*s)
# Kp (1 + Tn*s)
# -------------
#     Tn*s  
mutable struct PI <: Controller
    Kp
    Tn
    tf::TransferFunction
end

PI(Kp, Tn) = PI(Kp, Tn, pi_tf(Kp, Tn))
pi_tf(Kp, Tn) = tf([Kp]) * tf([Tn, 1], [Tn, 0])

setKp!(ctrl::PI, Kp) = (ctrl.Kp = Kp; ctrl.tf = pi_tf(Kp, ctrl.Tn))
setTn!(ctrl::PI, Tn) = (ctrl.Tn = Tn; ctrl.tf = pi_tf(ctrl.Kp, Tn))

mutable struct PI_parallel <: Controller
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
mutable struct PDT <: Controller
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

mutable struct PDT_parallel <: Controller
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
# Standard PIDT controller:
#G = Kp + Ki/s + Kd*s/(Td*s+1) = ((Kp*Td + Kd)*s^2 + (Kp+Ki*Td)*s + Ki)/(s*(1 + Td*s)) 
mutable struct PIDT <: Controller
    Kp # different from parallel Kp
    Tn
    Tv
    Td
    tf::TransferFunction
end

PIDT(Kp, Tn, Tv, Td) = PIDT(Kp, Tn, Tv, Td, pidt_tf(Kp, Tn, Tv, Td))
pidt_tf(Kp, Tn, Tv, Td) = tf([Kp]) * tf([Tn*Tv, Tn+Tv, 1], [Tn*Td, Tn, 0])

setKp!(ctrl::PIDT, Kp) = (ctrl.Kp = Kp; ctrl.tf = pidt_tf(Kp, ctrl.Tn, ctrl.Tv, ctrl.Td))
setTn!(ctrl::PIDT, Tn) = (ctrl.Tn = Tn; ctrl.tf = pidt_tf(ctrl.Kp, Tn, ctrl.Tv, ctrl.Td))
setTv!(ctrl::PIDT, Tv) = (ctrl.Tv = Tv; ctrl.tf = pidt_tf(ctrl.Kp, ctrl.Tn, Tv, ctrl.Td))
setTd!(ctrl::PIDT, Td) = (ctrl.Td = Td; ctrl.tf = pidt_tf(ctrl.Kp, ctrl.Tn, ctrl.Tv, Td))

mutable struct PIDT_parallel <: Controller
    Kp
    Ki
    Kd
    Td
    tf::TransferFunction
end

PIDT_parallel(Kp, Ki, Kd, Td) = PIDT_parallel(Kp, Ki, Kd, Td, PIDT_parallel_tf(Kp, Ki, Kd, Td))
PIDT_parallel_tf(Kp, Ki, Kd, Td) = tf([Kp]) + tf([Ki], [1, 0]) + tf([Kd, 0], [Td, 1])

setKp!(ctrl::PIDT_parallel, Kp) = (ctrl.Kp = Kp; ctrl.tf = PIDT_parallel_tf(Kp, ctrl.Ki, ctrl.Kd, ctrl.Td))
setKi!(ctrl::PIDT_parallel, Ki) = (ctrl.Ki = Ki; ctrl.tf = PIDT_parallel_tf(ctrl.Kp, Ki, ctrl.Kd, ctrl.Td))
setKd!(ctrl::PIDT_parallel, Kd) = (ctrl.Kd = Kd; ctrl.tf = PIDT_parallel_tf(ctrl.Kp, ctrl.Ki, Kd, ctrl.Td))
setTd!(ctrl::PIDT_parallel, Td) = (ctrl.Td = Td; ctrl.tf = PIDT_parallel_tf(ctrl.Kp, ctrl.Ki, ctrl.Kd, Td))

function parallel(ctrl::PIDT) 
    Kp = ctrl.Kp * (1 + (ctrl.Tv - ctrl.Td)/ctrl.Tn)
    Ki = ctrl.Kp/ctrl.Tn
    Kd = ctrl.Kp * (ctrl.Tv - ctrl.Td * (ctrl.Tn + ctrl.Tv - ctrl.Td)/ctrl.Tn)
    Td = ctrl.Td
    return PIDT_parallel(Kp, Ki, Kd, Td)
end

function serial(ctrl::PIDT_parallel) 
    Kp = ctrl.Kp
    Tn = ctrl.Ki/ctrl.Kp
    Tv = ctrl.Kp/ctrl.Kd
    Td = ctrl.Td
    return PIDT(Kp, Tn, Tv, Td)
end
############################################################################
