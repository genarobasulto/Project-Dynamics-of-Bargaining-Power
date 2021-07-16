function min_delta(h)
    """
    This function returns the minimun bargaining porwer of the agent that guarantees interior solutions
    """
    delta = 0 
    #Solve high effort for delta_0 = 0
    uh, vh, xl, xh, stat_high = Model_High_Effort(h, delta, 1, zeros(1), zeros(1))
    #Solve low eefort for delta_0 = 0
    ul, vl, xl, xh, stat_low = Model_Low_Effort(h, delta,1, zeros(1), zeros(1))
    #Choose the model that optimizes the weighted utility sum. 
    if delta*vh+(1-delta)*uh>delta*vl+(1-delta)*ul
            v = vh
        else
            v = vl 
        end
    vf = copy(v) 
    #Search delta_t such that we find interior solution 
    while round.(v,digits = 5) == round.(vf,digits = 5)
        delta += 0.01 #Update delta_t
        #Solve high effort for delta_t
        uh, vh, xl, xh, stat_high = Model_High_Effort(h, delta, 1, zeros(1), zeros(1))
        #Solve low effort for delta_t
        ul, vl, xl, xh, stat_low = Model_Low_Effort(h, delta,1, zeros(1), zeros(1))
        #Choose the model that optimizes the weighted utility sum.
        if delta*vh+(1-delta)*uh>delta*vl+(1-delta)*ul
            vf = vh
        else
            vf = vl 
        end
    end
    return delta - 0.01 #Return delta_min 
end


function max_delta(h)
    """
    This function returns the maximum bargaining porwer of the agent that guarantees interior solutions
    """
    delta = 1
    #Solve high effort for delta_0 = 1
    uh, vh, xl, xh, stat_high = Model_High_Effort(h, delta, 1, zeros(1), zeros(1))
    #Solve low effort for delta_0 = 1
    ul, vl, xl, xh, stat_low = Model_Low_Effort(h, delta, 1, zeros(1), zeros(1))
    #Choose the model that optimizes the weighted utility sum.
    if delta*vh+(1-delta)*uh>delta*vl+(1-delta)*ul
        v = vh
    else
        v = vl 
    end
    vf = copy(v)
    #Search delta_t such that we find interior solution 
    while round.(v,digits = 5) == round.(vf,digits = 5)
        delta -= 0.01
        #Solve high effort for delta_t
        uh, vh, xl, xh, stat_high = Model_High_Effort(h, delta,1, zeros(1),zeros(1))
        #Solve low effort for delta_t
        ul, vl, xl, xh, stat_low = Model_Low_Effort(h, delta, 1, zeros(1), zeros(1))
        #Choose the model that optimizes the weighted utility sum.
        if delta*vh+(1-delta)*uh>delta*vl+(1-delta)*ul
            vf = vh
        else
            vf = vl 
        end
    end
    return delta+0.01 #return delta_max
end