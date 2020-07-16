# https://dataverse.harvard.edu/file.xhtml?persistentId=doi:10.7910/DVN/FIE0S4/XH3RRJ&version=1.2

module Taylor

   using DelimitedFiles
   using Plots
   using LaTeXStrings

   const minWinSize=10

   tab=Array{Float64,1}
   mu=Array{Float64,1}
   mu2=Array{Float64,1}
   tit=String
   dir=String

   function Init(pdir::String,datafile::String,ptit::String)
      global tab,mu,mu2,tit,dir
      tit=ptit
      dir=pdir

      tab=readdlm(dir*datafile);
      dir=dir*"/PDF/"
      n=length(tab)
      mu=zeros(Float64,n,1);
      mu2=zeros(n,1);
println(ptit)
println("mintab=",minimum(tab),", maxtab=",maximum(tab)) # make it positive

      tmp=minimum(tab) # make it positive
      if tmp<=0
         tab=tab.-tmp.+0.01
      end
      gr()
      tmp=", RAW, n=$(n)"
      plot(tab,seriestype=:scatter,title=tit*", n=$(n), RAW",legend=false,markersize=1)  
      savefig(dir*ptit*", n=$(n), RAW.pdf")
   end

# p=10
   function Rajz(pp::Float64) # pp percent
      global tab,mu,mu2,tit,dir,minWinSize
      n=length(tab)
      p=div(Int(floor(n*pp)),100) #darab
      if p<minWinSize
         return
      end
      println("pp=",pp,", p=",p)
      s=sum(tab[1:p])
      s2=sum(tab[1:p].*tab[1:p])
      mu[1]=s/p;
      mu2[1]=s2/p;
      lo,up=1,p
      while up<n
         up+=1;
         s+=(tab[up]-tab[lo]);
         s2+=(tab[up]^2-tab[lo]^2);
         lo+=1;
         mu[lo]=s/p;
         mu2[lo]=s2/p;
      end
      ptit=tit*", n=$(n), ws=$(pp)%"
      gr()
      plot(log.(view(mu,1:lo)),log.(view(mu2,1:lo)),seriestype=:scatter,title=ptit*", LOGLOG",legend=false,markersize=1,color="red")  
      xlabel!(L"\log(\mu)")
      ylabel!(L"\log(\mu_2)")
      savefig(dir*ptit*", LOGLOG.pdf")

      plot(view(mu,1:lo),view(mu2,1:lo),seriestype=:scatter,title=ptit*", PLAIN",legend=false,markersize=1,color="red")  
      xlabel!(L"\mu")
      ylabel!(L"\mu_2")
      savefig(dir*ptit*", PLAIN.pdf")

      # mu[1]=sqrt(mu[1]^2+mu2[1]^2)
      # for it in 2:lo
      #    mu[it]=sqrt(mu[it]^2+mu2[it]^2)
      # end
      # plot(view(mu,1:lo),seriestype=:scatter,title=ptit*", DIST",legend=false,markersize=1)  
      # savefig(dir*ptit*", DIST.pdf")
   end

end
