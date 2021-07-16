function run_static_model(V, K)
    
    UF = [] # List of final values of the principal utility
    AcOpt = [] # List of optimal actions for K
    WHOpt = [] # List of hight optimal compensation for K
    WLOpt = [] # List of low optimal compensation for K
    KFact = [] #list of feasible indexes 
    
    for k in K # For each k from 19 to 90 it is optimized.

        uval = 0 # Initial optimal utility of Principal for k.
        wl = 0 # Initial compensation if yl occurs.
        wh = 0 # Initial compensation if yh occurs.
        accopt = 0 # Initial optimal action.

        uh, xh, xl, stat_high = Model_High_Effort(k, h)

        # If the solution found is optimal and feasible, then:
        # The optimal value is saved; as well as the compensations scheme and the value ah for k.
        if (uh > uval) & (stat_high == MOI.LOCALLY_SOLVED) 
            uval = uh
            wh = xh
            wl = xl
            accopt = A[2]
        end

        ul, xh, xl, stat_low = Model_Low_Effort(k, h) 

        # If the solution found is optimal, for now u=uh, and feasible, then:
        # The optimal value is saved; as well as the compensations scheme and the value ah for k.
        if (ul > uval) & (stat_low == MOI.LOCALLY_SOLVED) 
            uval = ul
            wh = xh
            wl = xl
            accopt = A[1]
        end
        
        if uval != 0
            append!(KFact, k) # Save  k.
            append!(UF, uval) # Save the Value Function for k.
            append!(WLOpt, wl) # Save the optimal low compensation for k.
            append!(WHOpt, wh) # Save the optimal hight compensation for k.
            append!(AcOpt, accopt) # Save the optimal effort for k.
            
            # Results are printed for k
            println("K=",k,"   ",uval, "   ", wl ,"    ",wh,"    ", accopt)
        end

    end

    # The DataFrame is created
    DataEst = DataFrame(
        K = KFact, 
        Agent_Utility = V[KFact],
        Principal_Utility = UF,
        High_Compensation = WHOpt,
        Low_Compensation = WLOpt,
        Effort = AcOpt)
    return DataEst
end