function Dynamic_Pareto_Frontier(Deltas, n, V, VF, U0, UF, digits_tol, Max_iter, h)
    """
    This functions finds the stationary point of the Bellman Equation for 
    the multi objective dynamic model with bargaining power dynamics
    Returns optimal values if found 
    """
    iter=0 #numero de iteraciones para enontrar el punto estacionario 
    AcOpt = [] # List of optimal actions for K
    WHOpt = [] # List of hight optimal compensation for K
    WLOpt = [] # List of low optimal compensation for K
    DFH=ones(n).*n #List of next period promised bargaining power if output yh occurs
    DFL=ones(n) #List of next period promised bargaining power if output yl occurs

    while round.(U0,digits = digits_tol)!=round.(UF,digits = digits_tol)  #loop to find thestationary point of the principal Utility
    
        AcOpt=[] # List of optimal actions for K
        WHOpt=[] # List of hight optimal compensation for K
        WLOpt=[] # List of low optimal compensation for K
        U0=UF #Update of the state variable (Princial Utility)
        V = VF #Update of the state variable (Agent Utility)
        UF=zeros(n) #Inital Value in the loop for Princial Utility
        VF = zeros(n) #Inital Value in the loop for Agent Utility
        
        for d in 1:n #Loop for bargaining powers
            
            delta = Deltas[d] #Current bargaining power
            uval = -10000 #Initialization of the agent utility for the current bargaining power
            vval = -10000 #Initialization of the principal utility for the current bargaining power
            wl=0 #Initialization of the low compensation for the current bargaining power
            wh=0 #Initialization of the high compensation for the current bargaining power
            accopt=0 #Initialization of the recomended effort for the current bargaining power
            p=0 #Initialization of the promised bargaining power|yh 
            q=0 #Initialization of the promised bargaining power|yl
            val = -10000 #Initialization of the weighted sum of the agent and pricial's utilities for the current bargaining power
            P = min(d+2, n) #Index for the next period bargaining power if output yh is observed
            Q = max(d-1, 1) #Index for the next period bargaining power if output yl is observed
                    
            #Solve the model for high effort given the current bargaining power
            uh, vh, xl, xh, stat_high = Model_High_Effort(h, delta, P, Q, U0, V) 

            #If the weighted sum of utilities is higher than it's last value
            if (delta*vh+(1-delta)*uh>val) & (stat_high == MOI.LOCALLY_SOLVED) 
                val = delta*vh+(1-delta)*uh #Update sum of utilities 
                uval=uh #Update optimal value for the princial utility
                vval = vh #Update optimal value for the agent utility
                wh=xh #Update optimal value for the high compensation 
                wl=xl #Update optimal value for the low compensation
                accopt=A[2] #Udate optimal reccomended action                       
            end

            #Solve the model for low effort given the current bargaining power
            ul, vl, xl, xh, stat_low = Model_Low_Effort(h, delta, P, Q, U0, V)

            #If the weighted sum of utilities is higher than it's last value
            if (delta*vl+(1-delta)*ul>val) & (stat_low == MOI.LOCALLY_SOLVED)
                val=delta*vl+(1-delta)*ul #Update sum of utilities 
                uval=ul #Update optimal value for the princial utility
                vval = vl #Update optimal value for the agent utility
                wh=xh #Update optimal value for the high compensation 
                wl=xl #Update optimal value for the low compensation
                accopt=A[1] #Udate optimal reccomended action 
            end
            
            #Save all optimal values for the current bargaining power
            UF[d] = uval 
            VF[d] = vval 
            append!(WHOpt, wh)
            append!(WLOpt,wl)
            append!(AcOpt, accopt)
            DFH[d] = P
            DFL[d] = Q
            
            if iter<=1 
                #Print Results
                print("Delta= ", round(delta,digits = 4), "  u=", round(uval,digits = 2),"   wh=", round(wh,digits = 2), "   wl=", round(wl,digits = 2), "  P=",P,"  Q=",Q,"  Acc= ", accopt, "\n")
            end
        end
        
        iter+=1 #Update iteration counter
        #println(iter) #Print current iteration 
        
        if iter == Max_iter #If number of iteration reaches max, finish the method.
            break
        end

    end
    #Save stationary result of all variables in dataframe 
    DataEstPoint = DataFrame(
    Deltas = Deltas,
    Utilidad_Agente=VF,
    Utilidad_Principal=UF,
    Compensacion_YH=WHOpt,
    Compensacion_YL=WLOpt,
    Accion_Recomendada=AcOpt, 
    DFH=DFH, 
    DFL=DFL)
    
    return DataEstPoint #Return Dataframe 
end