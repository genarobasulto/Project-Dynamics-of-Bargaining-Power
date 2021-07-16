function Model_High_Effort(h, delta, d, U0, V)
    """
    This functions declares and solves the High effort model for the weighted sum of agent and principal utilities 
    Returns optimal values if found 
    """
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
    register(model_high_effort, :v, 3, v, autodiff=true)    # m, the model name
                                            # :v,  **********                                          
                                            # 2, number of variables
                                            # v, declare the agent's utility function 
                                            # autodiff,    **********
    register(model_high_effort, :u, 2, u, autodiff=true) 

    # Non-linear type expressions are declared, the expected utility of the agent, within the model. 
    EV_H = @NLexpression(model_high_effort, f[1,1]*(v(xh,A[2], h)+beta*V[d])+f[1,2]*(v(xl,A[2],h)+beta*V[d]))    # E(v|ah)
    EV_L = @NLexpression(model_high_effort, f[2,1]*(v(xh,A[1],h)+beta*V[d])+f[2,2]*(v(xl,A[1],h)+beta*V[d]))    # E(v|al)
    EU_H = @NLexpression(model_high_effort, f[1,1]*(u(Y[2],xh)+beta*U0[d])+f[1,2]*(u(Y[1],xl)+beta*U0[d])) #E(U|ah)

    # Objective function; expected utility of the principal given ah.
    @NLobjective(model_high_effort, Max, delta*EV_H+(1-delta)*EU_H ) 

    @constraint(model_high_effort, xh<=Y[2])  # Financial capacity restriction for high compensation; wh<=yh.
    @constraint(model_high_effort, xl<=Y[1])  # Financial capacity restriction for low compensation; wl<=yl.

    @NLconstraint(model_high_effort, EV_H >= EV_L) # Incentive constraint to incentivize ah.
    
    # The problem posed for incentive ah is solved.
    JuMP.optimize!(model_high_effort) 
    wh = value(xh)
    wl = value(xl)
    uh = f[1,1]*(u(Y[2],wh)+beta*U0[d])+f[1,2]*(u(Y[1],wl)+beta*U0[d])
    vh = f[1,1]*(v(wh,A[2], h)+beta*V[d])+f[1,2]*(v(wl,A[2],h)+beta*V[d])
    return uh, vh, wl, wh, termination_status(model_high_effort)
end