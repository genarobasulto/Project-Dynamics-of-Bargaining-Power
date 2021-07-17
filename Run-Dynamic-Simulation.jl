include("Run_Dynamic_Model.jl")
include("Standard-Dynamic-Model\\declare-parameters-simulation-dynamic.jl")
include("Standard-Dynamic-Model\\declare-output-simulation.jl")
include("Standard-Dynamic-Model\\declare-one-period-simulation.jl")
include("Standard-Dynamic-Model\\declare-contract-simulation.jl")

Simulation_data = run_sim(k0, N)