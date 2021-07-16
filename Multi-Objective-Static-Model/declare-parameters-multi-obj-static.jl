A = [0.1 0.2]    			# Actions set [al ah]
Y = [0.4 0.8]    			# Outcomes set [yl yh]
f = [2/3 1/3; 1/3 2/3]    		# Probability matrix  [yh|ah yl|ah; yh|al yl|al]
beta = 0.96 				# Future discount factor
h = 0.5 				#Parameter for agent utility 
dl = min_delta(h) 			#Min bargaining power
dh =  max_delta(h) 			#Max bargaining power
println("Feasible bargaining powers:", dl,dh)
n = trunc(Int, ceil((dh-dl)*200+1)) 	#Number of intervals for the bargaining power
Deltas = LinRange(dl,dh,n) 		#List of bargaining powers