F=[2/7, 5/7]
x=[1,1,0,1]
l=[0,0,0,0,0]
u=[1,0,0,0,0]
for i in range(1,len(x)):
    l[i] = l[i-1] + (u[i-1]-l[i-1])*F[x[i]-1]
    u[i] = l[i-1] + (u[i-1]-l[i-1])*F[x[i]]
print(l)
print(u)
print(u[3]-l[3])
#0.05 , 0.07538
#0.02538