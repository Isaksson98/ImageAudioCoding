F=[0, 0.6, 0.9, 1]
x=[1,3,1,1]
l=[0,0,0,0,0]
u=[1,0,0,0,0]
for i in range(1,len(x)+1):
    l[i] = l[i-1] + (u[i-1]-l[i-1])*F[x[i-1]-1]
    u[i] = l[i-1] + (u[i-1]-l[i-1])*F[x[i-1]]
print(l[len(x)])
print(u[len(x)])
print(u[len(x)]-l[len(x)])
#print(l)
#print(u)