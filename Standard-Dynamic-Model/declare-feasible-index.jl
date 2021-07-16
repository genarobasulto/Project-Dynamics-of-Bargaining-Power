function feasible_Indexes(h, V, U0)
    """
    This functions finds the indexes where the principal optimization problem has a feasible solution.
    Returns array of feasible indexes. 
    """
    K0 = 1:10 #Initial guess of possible feasible indexes
    KN = 1:100 #Final set of possible feasible indexes
    
    #loop while the initial set and the final set of indexes are different 
    while K0 != KN 
    
        K0 = KN 
        KN = []

        for k in K0 #loop for each index in the set

            fact = 0 #factibility indicator 

            for P in k:K0[end] # Loop for comparison value 1

                for Q in K0[1]:k # Loop for comparison value 2

                    stat_high = Model_High_Effort(k, P, Q, h, V, U0)[4] #Solve the model for high effort, return termination status
        
                    if (stat_high == MOI.LOCALLY_SOLVED) #check if the model for high effort on index k if feasible, if so exit the loopfor comprasion value 2 
                        fact=1 
                        break    
                    end

                    stat_low = Model_Low_Effort(k,P,Q, h, V, U0)[4] #Solve the model for low effort, return termination status

                    if (stat_low == MOI.LOCALLY_SOLVED) #check if the model for low effort on index k if feasible, if so exit the loopfor comprasion value 2 
                        fact = 1
                        break
                    end

                end
                
                #if the index is feasible, break the loop for comprasion value 1 
                if fact == 1 
                    break
                end

            end
            
            #if the index is feasible, append it on the final set
            if fact == 1
                append!(KN, k)
            end

        end

        print(KN, "\n")

    end
    
    #Return the final set of feasible indexes
    return KN 
    
end