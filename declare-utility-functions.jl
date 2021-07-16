#v(c,a,g=1,alpha=1)=-exp(g*(a-alpha*c))  # Declaration of v (agent utility function); 
                                        # g is the coefficient of risk aversion
                                        # alpha is a cost coefficientv

v(c, a, h=0.5) =  c^(1-h)/(1-h)- a^2 #CRA Function 
                                    #h is a oefficient of risk aversion
                                    # a is the agent effort
u(y,w)=y-w  #Declaration of the principal utility function 
            #y is the current output
            #w is the salary paid to the agent