function sim_one_period(d)
    """
    This functions simulates one period in the contract given an initial level d.
    Returns current period compensation, action and output; next period delta and promised utilities. 
    """
    a = Est_point[d,"Accion_Recomendada"]
    y = output(a)
    comp = 0
    
    if y == Y[1]
        comp = Est_point[d, "Compensacion_YL"]
        d = max(d-1, 1)    
    else 
        comp = Est_point[d, "Compensacion_YH"]
        d = min(d+2, n)
    end
    ag_ut = v(comp, a, h) 
    pr_ut = u(y, comp) 
    return d, y, a, comp, ag_ut, pr_ut
end