function sim_one_period(k)
    """
    This functions simulates one period in the contract given an initial level k.
    Returns current period compensation, action and output; next period delta and promised utilities. 
    """
    a = DataEstPoint[k,"Accion_Recomendada"]
    y = output(a)
    comp = 0
    
    if y == Y[1]
        comp = DataEstPoint[k, "Compensacion_YL"] 
    else 
        comp = DataEstPoint[k, "Compensacion_YH"]
    end
    ag_ut = v(comp, a, h) 
    pr_ut = u(y, comp) 
    return y, a, comp, ag_ut, pr_ut
end