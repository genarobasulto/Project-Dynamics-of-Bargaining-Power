include("include-libraries.jl")
include("declare-utility-functions.jl")
include("Multi-Objective-No-Dynamics-Of-Bargaining-Power\\declare-high-effort-model-multi-obj-no-dynamics.jl")
include("Multi-Objective-No-Dynamics-Of-Bargaining-Power\\declare-low-effort-model-multi-obj-no-dynamics.jl")
include("Multi-Objective-No-Dynamics-Of-Bargaining-Power\\declare-feasible-bargaining-multi-obj-no-dynamics.jl")
include("Multi-Objective-No-Dynamics-Of-Bargaining-Power\\declare-parameters-multi-obj-no-dynamics.jl")
include("Multi-Objective-No-Dynamics-Of-Bargaining-Power\\declare-routine-multi-obj-no-dynamics.jl")

DataEstPoint_MOWS = Dynamic_Pareto_Frontier(Deltas, n, V, VF, U0, UF, digits_tol, Max_iter, h) 