module label
  include("utils.jl")
  using .utils
  
  function inilabel(gg,tipus="id")
    n=length(gg)
    if tipus[1]=='r' # relativ 
      p=parse(Float64,tipus[2:end])
      if p>1.0 p/=100.0 end
      nc=Int(floor(p*n))
      if nc<1.0 nc=1 end
      return rand(1:nc,n),nc
    end
    if tipus[1]=='a' # abszolut 
      nc=parse(Int,tipus[2:end])
      if nc>n nc=n end
      if nc<1.0 nc=1 end
      return rand(1:nc,n),nc
    end
    #if tipus=="id"
    [i for i in 1:n]
    #end        
  end


  # tobbseghez csatlakozas algo, label propagation
  function labelprop(gg,lab)
    n=length(gg)
    rget=utils.mkranord(n)

    ntie=0
    nchange=0
    while true
      change=0
      for _=1:n #sorrend?
        a=rget()
        la=lab[a]
        dd=Dict{Int,Int}()
        for b=gg[a]
          lb=lab[b]
          dd[lb]=get(dd,lb,0)+1
        end
        #println(d)
        mvdd=maximum(values(dd))
        bestneigh=[k for (k,v) in dd if v==mvdd]
        domi=rand(bestneigh)
        if mvdd>get(dd,la,0)
          change+=1
          ntie+=(length(bestneigh)>1)
          lab[a]=domi
        end
      end
      #println(change)
      0==change&&break
      nchange+=change
    end
    #println(lab)
    nchange,ntie
  end


  function postlab(lab) # egyforma lab-ja is lehet nem osszefuggo komponenseknek
    n=length(lab)
    sizes=[]
    dd=Dict{Int,Int}()
    nlab=0
    for a in 1:n
      v=lab[a]
      ddv=get(dd,v,-1)
      if ddv<0
        nlab+=1
        dd[v]=nlab
        ddv=nlab
        push!(sizes,0)
      end
      lab[a]=ddv
      sizes[ddv]+=1
    end
    sizes
  end


  function innerdeg(gg,lab,ns)
    n=length(gg)
    deg=fill(0,n)
    mu=fill(0.0,ns)
    mu2=fill(0.0,ns)
    for a=1:n
      la=lab[a]
      deg[a]=count(x->lab[x]==la,gg[a])
      mu[la]+=deg[a]
      mu2[la]+=deg[a]^2
    end
    deg,mu,mu2
  end

end
