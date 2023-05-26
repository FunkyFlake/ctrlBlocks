module Controllers

using ControlSystemsBase

# Standard PI controller: 
#G = Kp + Ki/s = Kp + Kp/(Tn*s) = Kp(1 + 1/(Tn*s)
# Kp (1 + Tn*s)
# -------------
#     Tn*s  
function pi_ctrl(Kp::Real, Tn::Real=1.0; Ki=nothing) 
    # check which kwarg is used
    if Ki === nothing
        return tf([Kp]) + tf([Kp], [Tn, 0])
    else
        return tf([Kp]) + tf([Ki], [1, 0])    
    end
end

end