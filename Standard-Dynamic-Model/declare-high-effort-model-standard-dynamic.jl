function Model_High_Effort(k, P, Q, h, V, U0)
    """
    This functions declares and solves the High effort model for the principal utility
    Returns optimal values if found 
    """
    model_high_effort = Model(with_optimizer(Ipopt.Optimizer, tol = 1e-7, max_iter = 1000, print_level=1)) 
    # A model to incentivize high effort is created specifying the optimization method

    #variables del modelo xl=wl, xh=wh
    @variable(model_high_effort, xl>=0.00001) 
    @variable(model_high_effort, xh>=0.00001)

    #Declare the agent's utility function within the model.

    register(model_high_effort, :v, 3, v, autodiff=true) # model_high_effort, the model name
                                            # :v,  **********                                          
                                            # 2, number of variables
                                            # v, declare the agent's utility function 
                                            # autodiff,    **********
    
    register(model_high_effort, :u, 2, u, autodiff=true) # model_high_effort, the model name
                                            # :u,  **********                                          
                                            # 2, number of variables
                                            # u, declare the principal's utility function 
                                            # autodiff,    **********

    #Non-linear type expressions are declared, the expected utility of the agent, within the model.
    EV_H = @NLexpression(model_high_effort, f[1,1]*(v(xh,A[2],h)+beta*V[P])+f[1,2]*(v(xl,A[2],h)+beta*V[Q])) #E(V|ah)
    EV_L = @NLexpression(model_high_effort, f[2,1]*(v(xh,A[1],h)+beta*V[P])+f[2,2]*(v(xl,A[1],h)+beta*V[Q])) #E(V|al)
    EU_H = @NLexpression(model_high_effort,f[1,1]*(u(Y[2],xh)+beta*U0[P])+f[1,2]*(u(Y[1],xl)+beta*U0[Q])) #E(U|ah)
    
    #Objective function; expected utility of the principal given ah.
    @NLobjective(model_high_effort, Max, EU_H) 

    @constraint(model_high_effort, xh<=Y[2]) #Financial capacity restriction for high compensation; wh<=yh.
    @constraint(model_high_effort, xl<=Y[1])  #Financial capacity restriction for low compensation; wl<=yl.
    @NLconstraint(model_high_effort, EV_H>=EV_L) #Incentive constraint to incentivize ah.
    @NLconstraint(model_high_effort, EV_H == V[k]) #Participation constraint to incentivize ah. 

    #The problem posed for incentive ah is solved.
    JuMP.optimize!(model_high_effort) 
    
    # The optimal value of the function is saved given ah.
    uh = getobjectivevalue(model_high_effort) 
    stat = termination_status(model_high_effort)
    wl = value(xl)
    wh = value(xh)
    
    return uh, wl, wh, stat
end