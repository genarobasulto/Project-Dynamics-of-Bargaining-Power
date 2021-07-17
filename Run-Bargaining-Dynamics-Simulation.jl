include("Run-Multi-Objective-Dynamics-Of-Bargaining-Model.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-parameters-simulation-bargaining-dynamics.jl")
include("Standard-Dynamic-Model\\declare-output-simulation.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-one-period-simulation-bargaining-dynamics.jl")
include("Multi-Objective-Dynamics-Of-Bargaining-Power\\declare-contract-simulation-bargaining-dynamics.jl")

Simulation_data = run_sim(d0, N)