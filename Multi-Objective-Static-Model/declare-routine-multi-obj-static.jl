function Static_Pareto_Frontier(Deltas, n, h)
    """
    This functions finds the pareto frontier for the Multi Objective Static Model  
    Returns optimal values if found 
    """
    u_val = 0 #Initialization of the principal utility for the current bargaining power
    v_val = 0 #Initialization of the agent utility for the current bargaining power
    U= [] #List of principal Utilities
    V= [] #List of agent utilities
    Acc_opt= [] #List of reccomended actions
    a = 0 #Initialization of the principal utility for the current bargaining power
    comp_opt = (0,0) #Tuple of compensations (wh,wl)
    Comp = [] #List of compensations
    for delta in Deltas #loop for bargaining power
        val = -100 #Initialization of the weighted sum of the agent and pricial's utilities for the current bargaining power

        #Solve the model for high effort given the current bargaining power
        uh, vh, comp_high, stat_high = Model_High_Effort(h, delta) 

        #If the weighted sum of utilities is higher than it's last value
        if delta*vh+(1-delta)*uh > val
            val = delta*vh+(1-delta)*uh #Update sum of utilities 
            u_val = uh #Update optimal value for the princial utility
            v_val = vh #Update optimal value for the agent utility
            a = A[2] #Udate optimal reccomended action 
            comp_opt = comp_high #Udate optimal compensations  
        end

        #Solve the model for low effort given the current bargaining power
        ul, vl, comp_low, stat_low = Model_Low_Effort(h, delta)

         #If the weighted sum of utilities is higher than it's last value
        if delta*vl+(1-delta)*ul > val  
            val = delta*vl+(1-delta)*ul #Update sum of utilities
            u_val = ul #Update optimal value for the princial utility
            v_val = vl #Update optimal value for the agent utility
            a = A[1] #Udate optimal reccomended action 
            comp_opt = comp_low #Udate optimal compensations  
        end

         #Save all optimal values for the current bargaining power
        append!(U, u_val)
        append!(V, v_val)
        append!(Acc_opt, a)
        push!(Comp, comp_opt)

    end

    #Save result of all variables in dataframe 
    Data_Weighted_Sum = DataFrame(
        Recomended_Action = Acc_opt,
        Delta = Deltas,
        Agent_Utility = V,
        Principal_Utility = U,
        High_Compensation = [comp[1] for comp in Comp],
        Low_Compensation = [comp[2] for comp in Comp])
    return Data_Weighted_Sum
end