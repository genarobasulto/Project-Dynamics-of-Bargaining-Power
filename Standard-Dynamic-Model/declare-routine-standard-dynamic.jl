function Dynamic_Pareto_Frontier(K, V, U0, UF, digits_tol, Max_iter, h)
    """
    This functions finds the stationary point of the Bellman Equation for
    the standard dynamic model.
    Returns optimal values if found 
    """
    
    iter=0 #Current number of method iteration 
    size_iter = length(K) #Size of the iteration 
    AcOpt = [] # List of optimal actions for K
    WHOpt = [] # List of hight optimal compensation for K
    WLOpt = [] # List of low optimal compensation for K
    VFH=zeros(100) #List of promised discounted utility for the principal if yh occurs.
    VFL=zeros(100)# List of promised discounted utility for the principal if yl occurs.
    for k in K
        VFH[k]=K[end]
        VFL[k]=K[1]
    end
    #loop while the initial value for the state variable is different from it's final value. 
    while round.(U0[K],digits = digits_tol)!=round.(UF[K],digits = digits_tol)
    
        AcOpt=[] #List of recomended actions 
        WHOpt=[] #List of compensations if yh occurs
        WLOpt=[] #List of compensations if yl occurs 
        U0[K]=UF[K] #Update state variable
        UF=zeros(100) #Final value of the state variable 

        for k in K # For each k in the feasible index set

            uval=0 #Value of the principal's current discounted utility 
            wl=0 #Low compensation 
            wh=0 #High compendation 
            accopt=0 #Recomended action 
            p=0 #Optimal comprasion value 1 
            q=0 #Optimal comprasion value 2 
 
            for P in k:min(K[end], Int(VFH[k])+3) # Loop for comparison value 1

                for Q in max(K[1],Int(VFL[k]-3)):k # Loop for comparison value 2

                    uh, xl, xh, stat_high = Model_High_Effort(k, P, Q, h, V, U0) #High Effort Model is Solved
                    
                    # If the principal's utility with the high effort action is higher than 0 and the model is feasible update the state variables
                    if (uh>uval) & (stat_high == MOI.LOCALLY_SOLVED)
                        uval=uh
                        wh=xh
                        wl=xl
                        p=P
                        q=Q
                        accopt=A[2]
                       
                    end

                    ul, xl, xh, stat_low = Model_Low_Effort(k, P, Q, h, V, U0)
                    
                    # If the principal's utility with the low effort action is higher than with the low effort and the model is feasible update the state variables
                    if (ul>uval) & (stat_low == MOI.LOCALLY_SOLVED)
                        uval=ul
                        wh=xh
                        wl=xl
                        p=P
                        q=Q
                        accopt=A[1]
                
                    end

                end
            end
            
            #The new values for the state variables are saved
            UF[k]=uval 
            append!(WHOpt, wh) 
            append!(WLOpt,wl)
            append!(AcOpt, accopt)
            VFH[k]=p
            VFL[k]=q
            
            if iter<=1 
                print("K= ", k, "  ul=", uval,"   wh=", wh, "   wl=", wl, "  P=",p,"  Q=",q,"  ", accopt, "\n")
            end
        end
        
        iter+=1 #Update number of iterations 
        println(iter)
        
        if iter == Max_iter #if the number of iterations is higher than the Max-iter, stationary point could not be found 
            break
        end

    end
    
    #Creation of the DataFrame
    DataEstPoint = DataFrame(
    K=K,
    Utilidad_Agente=V[K],
    Utilidad_Principal=U0[K],
    Compensacion_YH=WHOpt,
    Compensacion_YL=WLOpt,
    Accion_Recomendada=AcOpt, 
    VFH=VFH[K], 
    VFL=VFL[K])
    
    return DataEstPoint
end