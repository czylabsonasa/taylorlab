include("utils.jl")
using .utils

include("label.jl")
using .label

include("rajz.jl")
using .rajz

tbe,tki=utils.mktime()

tbe()

tbe()
datas=["ca-AstroPh","actor-collaboration", "loc-brightkite_edges","ucidata-zachary"]
data=datas[3]

gg,n,m=utils.olvas(data)
println("nodes, edges: ",(n,m))
println("olvas: ",tki()," sec")

#println(gg)


tbe()
lab=label.inilabel(gg,"id")
println("num. of labels: ",length(lab))
println("inilabel: ",tki()," sec")


tbe()
nchange,ntie=label.labelprop(gg,lab)
println("ties/changes:",ntie,"/",nchange,"=",ntie/nchange)
println("labelprop: ",tki()," sec")

#println(lab)

tbe()
sizes=label.postlab(lab)
ns=length(sizes)
println("labels left:",ns)
println("postlab: ",tki()," sec")


tbe()
deg,mu,mu2=label.innerdeg(gg,lab,ns)
println("innerdeg: ",tki()," sec")


tbe()
using Plots
#pyplot()
gr()
x=mu./sizes
y=mu2./sizes #.- x.*x
# see: https://docs.juliaplots.org/latest/output/ for show=true
plot(log.(x),log.(y),seriestype=:scatter,markersize=3,legend=false,show=true)
#histogram(sizes,show=true,normalize=:probability,bins=0:5:ns+1)
println("rajz: ",tki()," sec")


#rajz.grafrajz(gg,lab,data)

println("osszes: ", tki()," sec")
