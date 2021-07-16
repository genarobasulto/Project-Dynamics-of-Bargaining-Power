A = [0.1 0.2]    					    # Actions set [al ah]
Y = [0.4 0.8]    					    # Outcomes set [yl yh]
f = [2/3 1/3; 1/3 2/3]    				    # Probability matrix  [yh|ah yl|ah; yh|al yl|al]
beta = 0.96    						    # Future discount factor
N = 100    						    # Number of intervals for the state variable
Max_iter = 250 						    # Max number of iterations 
digits_tol = 3 						    # Digits of precision of the solution  
vl = v(0,A[2], h)/(1-beta) 			 	    # State variable`s lower limit 
vh = ((1/3)*v(Y[1],A[1],h)+(2/3)*v(Y[2],A[1],h))/(1-beta)   # State variable's upper limit
V = LinRange(vl, vh, N) 				    # State variable's vector 
UF = zeros(100) 					    # List of final values of the principal utility
U0 = ones(100) 						    # State variable's initial value