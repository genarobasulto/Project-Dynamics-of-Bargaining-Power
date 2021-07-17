function run_sim(k, N)
    """
    This functions simulates a number (N) of contract periods.  
    Returns simulation data with implemented effort levels, 
    bargaining powers,outputs and compentations. 
    """
    Ac = []
    Out = []
    Comps = []
    Agent = []
    Principal = []
    disc_ag = 0 
    disc_pr = 0
    for i in 1:N
        y, a, comp, ag_ut, pr_ut = sim_one_period(k)
        disc_ag += (beta^(i-1))*ag_ut
        disc_pr += (beta^(i-1))*pr_ut
        append!(Ac, a)
        append!(Out, y)
        append!(Comps, comp)
        append!(Agent, disc_ag)
        append!(Principal, disc_pr)
    end
    res_sim = DataFrame(
    Effort = Ac,
    Compensations = Comps,
    Outputs = Out, 
    Agent_Utility = Agent, 
    Principal_Utility = Principal)
    return res_sim
end