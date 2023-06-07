function staticFilter(Gcl::TransferFunction)
    if Gcl(0)[1] == Inf
        throw(error("Closed Loop Transfer Function already has infinite DC gain"))
    else
        return tf([1/Gcl(0)[1]])
    end
end

function staticFilter(Gcl::SysTF)
    if Gcl.tf(0)[1] == Inf
        throw(error("Closed Loop Transfer Function already has infinite DC gain"))
    else
        return tf([1/Gcl.tf(0)[1]])
    end
end

############################################################################
# Dynamic Filters for step inputs
# r: reference signal
# t: timepoints
# Second implementation returns u(x,t) for use in lsim or ODE package
############################################################################
# PT1 dynamic filter for reference signal - vector version
# τ: time constant
filterPT1(ref, t, τ) = ref * (1 .- exp.(-t/τ))
filterPT1(ref, τ) = (x,t) -> [ref * (1 - exp(-t/τ))] 
############################################################################
# Ramp filter 
filterRamp(ref, t, Tend) = ref * min.(1, t ./ Tend)
filterRamp(ref, Tend) = (x,t) -> [ref * min(1, t / Tend)]
############################################################################
# Squared sine filter
filterSqSine(ref, t, Tend) = ref * sin.(π/2 * min.(1, t ./ Tend)).^2
filterSqSine(ref, Tend) = (x,t) -> [ref * sin(π/2 * min(1, t / Tend))^2]
############################################################################