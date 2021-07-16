include("include-libraries.jl")
include("declare-utility-functions.jl")
include("Standard-Dynamic-Model\\declare-parameters-standard-dynamic.jl")
include("Standard-Dynamic-Model\\declare-low-effort-model-standard-dynamic.jl")
include("Standard-Dynamic-Model\\declare-high-effort-model-standard-dynamic.jl")
include("Standard-Dynamic-Model\\declare-feasible-index.jl")
include("Standard-Dynamic-Model\\declare-routine-standard-dynamic.jl")


K = feasible_Indexes(h, V, U0)                                               #Find feasible indexes for a given value of h 
DataEstPoint = Dynamic_Pareto_Frontier(K, V, U0, UF, digits_tol, Max_iter, h) #Run the routine to find the stationary point