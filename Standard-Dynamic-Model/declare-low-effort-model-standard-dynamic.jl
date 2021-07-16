function Model_Low_Effort(k,P,Q,h, V, U0)
    """
    This functions declares and solves the Low effort model for the principal utility
    Returns optimal values if found 
    """
    
    # A optimization model is created to incentive al.
    model_low_effort = Model(with_optimizer(Ipopt.Optimizer, tol = 1e-7, max_iter = 1000, print_level=1)) 

    #Declare the decision variables for the model: xl = wl, xh = wh.
    @variable(model_low_effort, xl>=0.00001) 
    @variable(model_low_effort, xh>=0.00001)

    #Declare the agent's utility function within the model.
    register(model_low_effort, :v, 3, v, autodiff=true) # model_low_effort, the model name
                                            # :v,  **********                                          
                                            # 3, number of variables
                                            # v, declare the agent's utility function 
                                            # autodiff,    **********
    register(model_low_effort, :u, 2, u, autodiff=true)# model_low_effort, the model name
                                            # :u,  **********                                          
                                            # 2, number of variables
                                            # u, declare the principal's utility function 
                                            # autodiff,    **********
    
    # Non-linear type expressions are declared, the expected utility of the agent, within the model.
    
    EV_H = @NLexpression(model_low_effort, f[1,1]*(v(xh,A[2],h)+beta*V[P])+f[1,2]*(v(xl,A[2],h)+beta*V[Q])) #E(V|ah)
    EV_L = @NLexpression(model_low_effort, f[2,1]*(v(xh,A[1],h)+beta*V[P])+f[2,2]*(v(xl,A[1],h)+beta*V[Q])) #E(V|al)
    EU_L = @NLexpression(model_low_effort,f[2,1]*(u(Y[2],xh)+beta*U0[P])+f[2,2]*(u(Y[1],xl)+beta*U0[Q])) # E(u|al))
    
    # Objective function; expected utility of the principal given al.l
    @NLobjective(model_low_effort, Max, EU_L) 

    @constraint(model_low_effort, xh <= Y[2]) # Financial capacity restriction for high compensation; wh<=yh.
    @constraint(model_low_effort, xl <= Y[1]) # Financial capacity restriction for low compensation; wl<=yl.
    
    @NLconstraint(model_low_effort, EV_H <= EV_L)  # Incentive constraint to incentivize al.
    @NLconstraint(model_low_effort, EV_L == V[k])  # Participation constraint to incentivize al.

    # The problem posed for incentive al is solved.
    JuMP.optimize!(model_low_effort)
    
    # The optimal value of the function is saved given al.
    ul=getobjectivevalue(model_low_effort) #Se guarda el valor optimo de la funcion para al
    stat = termination_status(model_low_effort)
    wl = value(xl)
    wh = value(xh)
    
    return ul, wl, wh, stat
end