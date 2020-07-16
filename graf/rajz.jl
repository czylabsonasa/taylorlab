module rajz
  using LightGraphs,Plots,GraphPlot, Colors,Compose, Cairo,Fontconfig
  function grafrajz(gg,col,name)
    lg=Graph()
    n=length(gg)
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



end