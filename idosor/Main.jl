include("Taylor.jl")
using .Taylor

# Taylor.Init("humidity/","humidity.txt","hourly humidity")
# Taylor.Init("temperature/","temperature.txt","hourly temperature")
# Taylor.Init("oil/","oil.txt","daily brent oil prices")
# Taylor.Init("oil2/","oil2.txt","daily brent oil prices eu")
# Taylor.Init("gold/","gold.txt","monthly gold prices, london")
# Taylor.Init("gas/","gas.txt","daily natural gas prices, us")
# Taylor.Init("co2/","co2.txt","co2, ppm averages")

# Taylor.Init("vix/","open.txt","vix, open")
# Taylor.Init("vix/","high.txt","vix, high")
# Taylor.Init("vix/","low.txt","vix, low")
# Taylor.Init("vix/","close.txt","vix, close")


Taylor.Init("ice_extent_N/","ice.txt","ice extent, northern hemisphere,")





println("n=",length(Taylor.tab))


Taylor.Rajz(0.1)
Taylor.Rajz(0.2)
Taylor.Rajz(0.4)
Taylor.Rajz(0.8)
Taylor.Rajz(1.0)
Taylor.Rajz(2.0)
Taylor.Rajz(4.0)
Taylor.Rajz(8.0)
Taylor.Rajz(16.0)
Taylor.Rajz(32.0)

