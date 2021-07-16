include("include-libraries.jl")
include("declare-utility-functions.jl")
include("Standard-Static-Model\\declare-parameters-standard-static.jl")
include("Standard-Static-Model\\declare-low-effort-model-standard-static.jl")
include("Standard-Static-Model\\declare-high-effort-model-standard-static.jl")
include("Standard-Static-Model\\declare-routine-standard-static.jl")

DataEst = run_static_model(V, K)
