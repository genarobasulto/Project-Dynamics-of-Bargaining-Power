function Model_Low_Effort(h, delta)
    """
    This functions declares and solves the Low effort model for the weighted sum of agent and principal utilities 
    Returns optimal values if found 
    """
    model_low_effort = Model(
        with_optimizer(
            Ipopt.Optimizer, 
            tol = 1e-7, 
            max_iter = 1000,
            print_level=1))

    # Declare the decision variables for the model: xl = wl, xh = wh.
    @variable(model_low_effort, xl >= 0.00001)  # xl = wl, low compensation.
    @variable(model_low_effort, xh >= 0.00001)  # xh = wh, hight compensation.

    # Declare the agent's utility function within the model.
    register(model_low_effort, :v, 3, v, autodiff=true)    # m, the model name
                                            # :v,  **********                                          
                                            # 2, number of variables
                                            # v, declare the agent's utility function 
                                            # autodiff,    **********

    register(model_low_effort, :u, 2, u, autodiff=true) 

    # Non-linear type expressions are declared, the expected utility of the agent, within the model. 
    EV_H = @NLexpression(model_low_effort, f[1,1]*v(xh,A[2], h) + f[1,2]*v(xl,A[2],h)) #E(v|ah)
    EV_L = @NLexpression(model_low_effort, f[2,1]*v(xh,A[1], h) + f[2,2]*v(xl,A[1],h)) #E(v|al)
    EU_L = @NLexpression(model_low_effort,  f[2,1]*u(Y[2],xh)+f[2,2]*u(Y[1],xl)) #E(U|al)

    # Objective function; expected utility of the principal given al.
    @NLobjective(model_low_effort, Max, delta*EV_L+(1-delta)*EU_L) 

    @constraint(model_low_effort, xh <= Y[2]) # Financial capacity restriction for high compensation; wh<=yh.
    @constraint(model_low_effort, xl <= Y[1]) # Financial capacity restriction for low compensation; wl<=yl.

    @NLconstraint(model_low_effort, EV_H <= EV_L)  # Incentive constraint to incentivize al.

    # The problem posed for incentive al is solved.
    JuMP.optimize!(model_low_effort)

    # The optimal value of the function is saved given al.
    wh = value(xh)
    wl = value(xl)
    ul = (f[2,1]*u(Y[2],wh)+f[2,2]*u(Y[1],wl))/(1-beta)
    vl = (f[2,1]*v(wh,A[1], h) + f[2,2]*v(wl,A[1],h))/(1-beta)
    
    return ul, vl, (wh, wl), termination_status(model_low_effort)
end