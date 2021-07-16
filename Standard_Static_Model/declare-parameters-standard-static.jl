A = [0.1 0.2]                               # Actions set [al ah]
Y = [0.4 0.8]                               # Outcomes set [yl yh]
f = [2/3 1/3; 1/3 2/3]                      # Probability matrix  [yh|ah yl|ah; yh|al yl|al]
beta = 0.99                                 # Future discount factor
N = 100                                     # Number of intervals for the state variable
K= 1:100 
vl = v(0,A[2])                              # State variable's lower limit 
vh = (1/3)*v(Y[1],A[1])+(2/3)*v(Y[2],A[1])  # State variable's upper limit
V = LinRange(vl, vh, N)                     # State variable's vector 
UF = []                                     # List of final values of the principal utility
AcOpt = []                                  # List of optimal actions for K
WHOpt = []                                  # List of hight optimal compensation for K
WLOpt = []                                  # List of low optimal compensation for K
h = 0.5                                     # Risk Adversion coeficcient