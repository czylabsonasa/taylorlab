#various simple functions
module utils

  function mktime() # dict jobb lenne?
    st=Float64[]
    function start()
      push!(st,time())[end]
    end
    function lap()
      if length(st)>0 floor(1000.0*(time()-pop!(st)))/1000.0 else -1.0 end
    end
    start,lap
  end

  # egyszeru ellista olvasas a data-filebol ("nem szammal kezdodo"-os sorok kihagyva, feltesszuk hogy korrekt)
  function olvas(data)
    data="data/"*data*"/out."*data #konect
    edges=Tuple{Int,Int}[]
    n,m=0,0
    for v=readlines(data)
      v=strip(v)
      !isdigit(v[1])&&continue
      a,b=parse.(Int,split(v))
      n=max(n,max(a,b))
      m+=1
      push!(edges,(a,b))
    end
    gg=[Int[] for _ in 1:n]
    for (a,b) in edges
      push!(gg[a],b)
      push!(gg[b],a)
    end
    gg,n,m
  end


  #1:n rang veletlen sorrendben 
  function mkranord(n)
    arr=collect(1:n)
    veg=n
    function rget()
      (veg<1)&&(veg=n)
      i=rand(1:veg)
      arr[i],arr[veg]=arr[veg],arr[i]
      veg-=1
      arr[veg+1]
    end
    rget
  end


end






