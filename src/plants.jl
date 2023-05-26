module Plants

using Revise, ControlSystemsBase

pt1(K::Real=1.0, T::Real=1.0) = tf([K], [T, 1])

end