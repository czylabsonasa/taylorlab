module taylor


  # tobbseghez csatlakozas algo
  function szinez(gg,col,nc)
    n=length(gg)
    rget=mkranord(n)

    ntie=0
    nchange=0
    while true
      change=0
      for _=1:n #sorrend?
        a=rget()
        ca=col[a]
        dd=Dict{Int,Int}()
        for b=gg[a]
          cb=col[b]
          dd[cb]=get(dd,cb,0)+1
        end
        #println(d)
        mvdd=maximum(values(dd))
        bneigh=[k for (k,v) in dd if v==mvdd]
        dom=rand(bneigh)
        if dom!=ca && mvdd>get(dd,ca,0)
          change+=1
          ntie+=(length(bneigh)>1)
          col[a]=dom
        end
      end
      #println(change)
      0==change&&break
      nchange+=change
    end
    sizes=[]
    dd=Dict{Int,Int}()
    nc=0
    for a in 1:n
      v=col[a]
      ddv=get(dd,v,-1)
      if ddv<0
        nc+=1
        dd[v]=nc
        ddv=nc
        push!(sizes,0)
      end
      col[a]=ddv
      sizes[ddv]+=1
    end
    col,sizes,nchange,ntie
  end

  function innerdeg(gg,col,ns)
    n=length(gg)
    deg=fill(0,n)
    mu=fill(0.0,ns)
    mu2=fill(0.0,ns)
    for a=1:n
      ca=col[a]
      deg[a]=count(x->col[x]==ca,gg[a])
      mu[ca]+=deg[a]
      mu2[ca]+=deg[a]^2
    end
    deg,mu,mu2
  end

end



function grafrajz(gg,name)
  lg=Graph()
  add_vertices!(lg,n)
  for a in 1:n
    for b in gg[a]
      add_edge!(lg,(a,b))
    end
  end

  dc=distinguishable_colors(n)
  #draw(PDF(name*".pdf"),gplot(lg,nodefillc=dc[col]))
  draw(PNG(name*".png",16cm,16cm), gplot(lg,nodefillc=dc[col]))

end