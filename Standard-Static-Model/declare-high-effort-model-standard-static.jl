function Model_High_Effort(k, h)
    # A optimization model is created to incentive ah.
    model_high_effort = Model(
        with_optimizer(
            Ipopt.Optimizer, 
            tol = 1e-7, 
            max_iter = 1000, 
            print_level=1)) 
    
    # Declare the decision variables for the model: xl = wl, xh = wh.
    @variable(model_high_effort, xl >= 0.00001)  # xl = wl, low compensation.
    @variable(model_high_effort, xh >= 0.00001)  # xh = wh, hight compensation.
    
    # Declare the agent's utility function within the model.
    register(model_high_effort, :v, 2, v, autodiff=true)    # m, the model name
                                            # :v,  **********                                          
                                            # 2, number of variables
                                            # v, declare the agent's utility function 
                                            # autodiff,    **********
    register(model_high_effort, :u, 2, u, autodiff=true)  
    
    # Non-linear type expressions are declared, the expected utility of the agent, within the model. 
    EV_H = @NLexpression(model_high_effort, f[1,1]*v(xh,A[2])+f[1,2]*v(xl,A[2]))    # E(v|ah)
    EV_L = @NLexpression(model_high_effort, f[2,1]*v(xh,A[1])+f[2,2]*v(xl,A[1]))    # E(v|al)
    EU_H = @NLexpression(model_high_effort, f[1,1]*u(Y[2],xh) + f[1,2]*u(Y[1],xl))    # E(u|ah)
    
    # Objective function; expected utility of the principal given ah.
    @NLobjective(model_high_effort, Max,  EU_H) 
    
    @constraint(model_high_effort, xh<=Y[2])  # Financial capacity restriction for high compensation; wh<=yh.
    @constraint(model_high_effort, xl<=Y[1])  # Financial capacity restriction for low compensation; wl<=yl.
    
    @NLconstraint(model_high_effort, EV_H >= EV_L) # Incentive constraint to incentivize ah.
    @NLconstraint(model_high_effort, EV_H == V[k]) # Participation constraint to incentivize ah.
    
    # The problem posed for incentive ah is solved.
    JuMP.optimize!(model_high_effort) 
    
    # The optimal value of the function is saved given ah.
    uh = getobjectivevalue(model_high_effort)/(1-beta) 
    wh = value(xh)
    wl = value(xl)
    return uh, wh, wl, termination_status(model_high_effort)
end