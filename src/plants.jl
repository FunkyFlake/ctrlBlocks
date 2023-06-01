p_tf(K=1) = tf([K])

pt1_tf(K=1, T=1) = tf([K], [T, 1])
pt2_tf(K=1, ω=1, ζ=1) = tf([K], [1/ω^2, 2*ζ/ω, 1])

i_tf(Ki=1) = tf([Ki], [1, 0])
it_tf(Ki=1, T=1) = tf([Ki], [T, 1, 0])

function ptn_tf(K=1, T=[]) # T is vector of time constants
    tfs = [tf([1], [T, 1]) for T in T]
    ptn = tf(K)
    for G in tfs
        ptn *= G
    end
    return ptn
end

function itn_tf(Ki=1, T=[])
    tfs = [tf([1], [T, 1]) for T in T]
    itn = tf([Ki], [1, 0])
    for G in tfs
        itn *= G
    end
    return itn
end


############################################################################
abstract type Plant end

mutable struct P <: Plant
    K
    tf::TransferFunction
end
P(K=1) = P(K, p_tf(K))


mutable struct PT1 <: Plant
    K
    T
    tf::TransferFunction
end
PT1(K=1, T=1) = PT1(K, T, pt1_tf(K, T))

mutable struct PT2 <: Plant
    K
    ω
    ζ
    tf::TransferFunction
end
PT2(K=1, ω=1, ζ=1) = PT2(K, ω, ζ, pt2_tf(K, ω, ζ))

mutable struct I <: Plant
    Ki
    tf::TransferFunction
end
I(Ki=1) = I(Ki, i_tf(Ki))

mutable struct IT1 <: Plant
    Ki
    T
    tf::TransferFunction
end
IT1(Ki=1, T=1) = IT1(Ki, T, it_tf(Ki, T))

mutable struct PTn <: Plant
    K
    T::Vector{}
    tf::TransferFunction
end
PTn(K=1, T::Vector{}=[]) = PTn(K, T, ptn_tf(K, T))

mutable struct ITn <: Plant
    Ki
    T::Vector{}
    tf::TransferFunction
end
ITn(Ki=1, T::Vector{}=[]) = ITn(Ki, T, itn_tf(Ki, T))