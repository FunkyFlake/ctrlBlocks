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

# PT1 dynamic filter for reference signal - vector version
# r: reference signal
# t: timepoints
# τ: time constant
filterPT1(ref, t, τ) = ref * (1 .- exp.(-t/τ))
# u(x,t) for use in lsim or ODE package
filterPT1(ref, τ) = (x,t) -> [ref * (1 - exp(-t/τ))] 
