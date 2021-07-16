include("include-libraries.jl")
include("declare-utility-functions.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-high-effort-model-multi-obj-dynamics.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-low-effort-model-multi-obj-dynamics.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-feasible-bargaining-multi-obj-dynamics.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-parameters-multi-obj-dynamics.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-routine-multi-obj-dynamics.jl")

DataEstPoint_MOWS = Dynamic_Pareto_Frontier(Deltas, n, V, VF, U0, UF, digits_tol, Max_iter, h) 