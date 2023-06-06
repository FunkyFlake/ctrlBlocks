abstract type Plant end
############################################################################
mutable struct P <: Plant
    K
    tf::TransferFunction
end

P(K=1) = P(K, p_tf(K))

p_tf(K=1) = tf([K])

setK(plant::P, K) = (plant.K = K; plant.tf = p_tf(K))
############################################################################
mutable struct PT1 <: Plant
    K
    T
    tf::TransferFunction
end

PT1(K=1, T=1) = PT1(K, T, pt1_tf(K, T))

pt1_tf(K=1, T=1) = tf([K], [T, 1])

setK(plant::PT1, K) = (plant.K = K; plant.tf = pt1_tf(K, plant.T))
setT(plant::PT1, T) = (plant.T = T; plant.tf = pt1_tf(plant.K, T))
############################################################################
mutable struct PT2 <: Plant
    K
    ω
    D
    tf::TransferFunction
end

PT2(K=1, ω=1, D=1) = PT2(K, ω, D, pt2_tf(K, ω, D))

pt2_tf(K=1, ω=1, ζ=1) = tf([K], [1/ω^2, 2*ζ/ω, 1])

setK(plant::PT2, K) = (plant.K = K; plant.tf = pt2_tf(K, plant.ω, plant.D))
setω(plant::PT2, ω) = (plant.ω = ω; plant.tf = pt2_tf(plant.K, ω, plant.D))
setD(plant::PT2, D) = (plant.D = D; plant.tf = pt2_tf(plant.K, plant.ω, D))
############################################################################
mutable struct I <: Plant
    Ki
    tf::TransferFunction
end

I(Ki=1) = I(Ki, i_tf(Ki))

i_tf(Ki=1) = tf([Ki], [1, 0])

setKi(plant::I, Ki) = (plant.Ki = Ki; plant.tf = i_tf(Ki))
############################################################################
mutable struct IT1 <: Plant
    Ki
    T
    tf::TransferFunction
end

IT1(Ki=1, T=1) = IT1(Ki, T, it1_tf(Ki, T))

it1_tf(Ki=1, T=1) = tf([Ki], [T, 1, 0])

setKi(plant::IT1, Ki) = (plant.Ki = Ki; plant.tf = it1_tf(Ki, plant.T))
setT(plant::IT1, T) = (plant.T = T; plant.tf = it1_tf(plant.Ki, T))
############################################################################
mutable struct PTn <: Plant
    K
    T::Vector{}
    tf::TransferFunction
end

PTn(K=1, T::Vector{}=[]) = PTn(K, T, ptn_tf(K, T))

function ptn_tf(K=1, T=[]) # T is vector of time constants
    tfs = [tf([1], [T, 1]) for T in T]
    ptn = tf(K)
    for G in tfs
        ptn *= G
    end
    return ptn
end

setK(plant::PTn, K) = (plant.K = K; plant.tf = ptn_tf(K, plant.T))
setT(plant::PTn, T::Vector{}) = (plant.T = T; plant.tf = ptn_tf(plant.K, T))
############################################################################

mutable struct ITn <: Plant
    Ki
    T::Vector{}
    tf::TransferFunction
end

ITn(Ki=1, T::Vector{}=[]) = ITn(Ki, T, itn_tf(Ki, T))

function itn_tf(Ki=1, T=[])
    tfs = [tf([1], [T, 1]) for T in T]
    itn = tf([Ki], [1, 0])
    for G in tfs
        itn *= G
    end
    return itn
end

setKi(plant::ITn, Ki) = (plant.Ki = Ki; plant.tf = itn_tf(Ki, plant.T))
setT(plant::ITn, T::Vector{}) = (plant.T = T; plant.tf = itn_tf(plant.Ki, T))
############################################################################
mutable struct TT <: Plant
    tau
    tf::TransferFunction
end

TT(tau=1) = TT(tau, tt_tf(tau))

tt_tf(tau=1) = delay(tau)