A = [0.1 0.2]    # Actions set [al ah]
Y = [0.4 0.8]    # Outcomes set [yl yh]
f = [2/3 1/3; 1/3 2/3]    # Probability matrix  [yh|ah yl|ah; yh|al yl|al]
beta = 0.96    # Future discount factor
h = 0.5 #Risk AdversionParameter for agent utility 
digits_tol = 3 #Digits of precision 
Max_iter = 300 #Limit of method iterations
dl = min_delta(h) #Min bargaining power
dh = max_delta(h) #Max bargaining power
println("Feasible Bargaining Powers: ", dl, ", ", dh)
eps = 0.01 #Dynamic of the bargaining power parameter 
n = trunc(Int, ceil((dh-dl)*(2/eps)+1)) #Bargaining power number of intervals
V = zeros(n) # State variable's initial value vector  
VF =  zeros(n) # State variable's final value vector  
UF = zeros(n) # List of final values of the principal utility
U0 = ones(n) # State variable's initial value
Deltas = LinRange(round(dl, digits = 2), round(dh, digits = 2),n) #List of admisible bargaining powers