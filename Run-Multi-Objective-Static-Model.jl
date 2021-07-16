include("include-libraries.jl")
include("declare-utility-functions.jl")
include("Multi-Objective-Static-Model\\declare-high-effort-model-multi-obj-static.jl")
include("Multi-Objective-Static-Model\\declare-low-effort-model-multi-obj-static.jl")
include("Multi-Objective-Static-Model\\declare-feasible-bargaining-multi-obj-static.jl")
include("Multi-Objective-Static-Model\\declare-parameters-multi-obj-static.jl")
include("Multi-Objective-Static-Model\\declare-routine-multi-obj-static.jl")

Data_Weighted_Sum = Static_Pareto_Frontier(Deltas, n, h)