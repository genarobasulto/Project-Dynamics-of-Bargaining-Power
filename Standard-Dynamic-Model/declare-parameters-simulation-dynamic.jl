A = [0.1 0.2]    								# Actions set [al ah]
Y = [0.4 0.8]    								# Outcomes set [yl yh]
f = [2/3 1/3; 1/3 2/3]    							# Probability matrix  [yh|ah yl|ah; yh|al yl|al]
beta = 0.96    									# Future discount factor
h = 0.5 									# Risk AdversionParameter for agent utility 
k0 = 45 									# Initial index of the contract
n = size(DataEstPoint)[1] 							# Dataframe lenght
N = 100 									# Number of periods to simulate