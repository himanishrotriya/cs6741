### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 0152aec0-781e-11eb-379f-af444aa94b69
using RDatasets,DataFrames,Random,Dates,Plots,HTTP,JSON,Statistics

# ╔═╡ f3a064c0-7f48-11eb-24ea-91db022cc794
pyplot()

# ╔═╡ b442db90-7e86-11eb-1235-bb704dceadae
md" # Question-1"

# ╔═╡ c1964e6e-7e87-11eb-2192-9f20f4631900
untidy1=DataFrame()

# ╔═╡ d1d41de0-7823-11eb-3aef-252bcd52e2b0
begin
	md" # Untidy Data"
	insertcols!(untidy1,:religion=>String[])
	insertcols!(untidy1,Symbol("<\$10k")=>Int[])
	insertcols!(untidy1,Symbol("\$10-20k")=>Int[])
	insertcols!(untidy1,Symbol("\$20-30k")=>Int[])
	insertcols!(untidy1,Symbol("\$30-40k")=>Int[])
	insertcols!(untidy1,Symbol("\$40-50k")=>Int[])
	insertcols!(untidy1,Symbol("\$50-75k")=>Int[])
	insertcols!(untidy1,Symbol("\$75-100k")=>Int[])
	insertcols!(untidy1,Symbol("\$100-150k")=>Int[])
	insertcols!(untidy1,Symbol(">\$150k")=>Int[])
	push!(untidy1,("Agnostic",27,34,60,81,76,137,122,109,84))
	push!(untidy1,("Atheist",12,27,37,52,35,70,40,50,55))
	push!(untidy1,("Buddhist",27,21,30,34,33,58,12,23,34))
	push!(untidy1,("Catholic",418,617,732,670,638,1116,1000,897,565))
	push!(untidy1,("Don't know/refused",15,14,15,11,10,35,11,12,13))
	push!(untidy1,("Evangelical Prot",575,869,1064,982,881,1486,787,757,742))
	push!(untidy1,("Hindu",1,9,7,9,11,34,3,8,1))
	push!(untidy1,("Historically Black Prot",228,244,236,238,197,223,175,167,763))
	push!(untidy1,("Jehovah's Witness",20,27,24,24,21,20,27,28,24))
	push!(untidy1,("Jewish",19,19,25,25,30,95,19,36,23))
	untidy1
	#insertcols!(untidy,Symbol("Don't know/refused")=>Int[])
end

# ╔═╡ a7485b40-783c-11eb-33bd-a7555e707e76
tidy1=sort(DataFrames.stack(untidy1,Not([:religion]),:religion,variable_name=:income,value_name=:freq),:religion)

# ╔═╡ 2ab8faae-7e88-11eb-1843-1db1d1335402
md" # Question-2"

# ╔═╡ e3a5f620-7f39-11eb-27c2-b30f5340c367
begin
	untidy2=DataFrame()
	insertcols!(untidy2,1,:id=>repeat(["MX17001","MX17002"],inner=12),:year=>repeat([2010,2011],inner=6,outer=2),:month=>repeat([1,2,3],inner=2,outer=4),:element=>repeat(["tmax","tmin"],outer=12))
	insertcols!(untidy2,5,:d1 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d2 => [31.3+2, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d3 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d4 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d5 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d6 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d7 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d8 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d9 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d10 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d11 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d12 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d13 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d14 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d15 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d16 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d17 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d18 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d19 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d20 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d21 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d22 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d23 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d24 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d25 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d26 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d27 =>[31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d28 => [31.3, 23.6, 45.9, 41.2, 32.6, 24.6, 35.6, 29, 28, 23,22.3,20,31,28,36,31,44,41,55,51,20,15,27,24],
	:d29 =>[31.3, 23.6, missing, missing, 32.6, 24.6, 35.6, 29, missing, missing,22.3,20,31,28,missing,missing,44,41,55,51,missing,missing,27,24],
	:d30 => [31.3, 23.6, missing, missing, 32.6, 24.6, 35.6, 29, missing, missing,22.3,20,31,28,missing,missing,44,41,55,51,missing,missing,27,24],
	:d31 => [31.3, 23.6, missing, missing, missing,missing, 35.6, 29, missing, missing,missing,missing,31,28,missing,missing,missing,missing,55,51,missing,missing,missing,missing])

end

# ╔═╡ 847a7260-7f3a-11eb-26f7-a1c045c1f78c
begin
	c=sort(DataFrames.stack(untidy2,Not([:id,:year,:month,:element]),variable_name=:day),[:id,:year,:month])
	b=unstack(c,:element,:value)
	dropmissing!(b)
	tidy2=select(b,:id,[:year,:month,:day]=>ByRow((e,f,g)->Dates.Date(e,f,parse(Int32,g[2:lastindex(g)])))=>:Date,Not([:id,:year,:month,:day]))
	
end

# ╔═╡ f10031b0-7f38-11eb-12f7-598bcfa92c39
md" # Question-3"

# ╔═╡ 272aec80-7f39-11eb-292d-79a2e271bc9e
begin
	untidy3=DataFrame(year=Int[],artist=String[],time=String[],track=String[],date=String[],week=Int[],rank=Int[])
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-02-26",1,87))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-03-04",2,82))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-03-11",3,72))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-03-18",4,77))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-03-25",5,87))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-04-01",6,94))
	push!(untidy3,(2000,"2 Pac","4:22","Baby Don't Cry","2000-04-08",7,99))
	push!(untidy3,(2000,"2Ge+her","3:15","The Hardest Part Of ...","2000-09-02",1,91))
	push!(untidy3,(2000,"2Ge+her","3:15","The Hardest Part Of ...","2000-09-09",2,87))
	push!(untidy3,(2000,"2Ge+her","3:15","The Hardest Part Of ...","2000-09-16",3,92))
	push!(untidy3,(2001,"3 Doors Down","3:53","Kryptonite","2001-04-08",1,81))
	push!(untidy3,(2001,"3 Doors Down","3:53","Kryptonite","2001-04-15",2,70))
	push!(untidy3,(2001,"3 Doors Down","4:15","Loser","2001-04-22",1,68))
	push!(untidy3,(2001,"3 Doors Down","4:15","Loser","2001-04-29",2,67))
	push!(untidy3,(2001,"504 Boyz","3:53","Wobble Wobble","2001-04-16",1,66))
	push!(untidy3,(2001,"504 Boyz","3:53","Wobble Wobble","2001-04-23",2,65))
	push!(untidy3,(2002,"Aguilera,Christina","3:50","Come on over Baby","2002-04-22",1,68))
	push!(untidy3,(2002,"Aguilera,Christina","3:50","Come on over Baby","2002-04-29",2,67))
	push!(untidy3,(2002,"Aguilera,Christina","4:00","I Turn To You","2002-05-06",1,77))
	push!(untidy3,(2002,"Aguilera,Christina","4:00","I Turn To You","2002-05-13",2,78))
end

# ╔═╡ 99da7140-7f3b-11eb-2420-617c48c9a303
begin
	tidy31=unique(select(untidy3,:artist,:track,:time))
	insertcols!(tidy31,1,:id=>1:length(tidy31.artist))
end

# ╔═╡ 20774ee0-7f3b-11eb-0b4a-ef96167e2a7c
begin
	tidy32=select(innerjoin(tidy31,untidy3,on=:track,makeunique=true),:id,:date,:rank)
end

# ╔═╡ df647e10-7f48-11eb-0066-517262ae9f4a
md" # Question-4"

# ╔═╡ 314b4a10-7f49-11eb-2796-93a6038d79ff
begin
	r=HTTP.request("GET","https://api.covid19india.org/data.json")
	a=JSON.Parser.parse(String(r.body))
	data=reduce(vcat, DataFrame.(a["cases_time_series"]))
	transformed_data=select(data,:,:dateymd=>ByRow(x->x[1:7])=>:month)
	gdf=groupby(transformed_data,:month)
end

# ╔═╡ 68290130-7f49-11eb-2694-4d63c53d7fb3
begin
	combine_gdf=combine(gdf,:dailyconfirmed=>(x->mean(parse.(Int64,x)))=>:agg_confirmed,:dailydeceased=>(x->mean(parse.(Int64,x)))=>:agg_deceased,:dailyrecovered=>(x->mean(parse.(Int64,x)))=>:agg_recovered)
end

# ╔═╡ 4105d1e0-7f4a-11eb-2f41-c3da31ef2390
md" # Question-5"

# ╔═╡ 57cb49a0-7f4a-11eb-09c8-1ddc72bed0dc
begin
	n=length(data.date)
	f=[]
	d=[]
	e=[]
	append!(f,repeat([missing],inner=6))
	append!(f,[mean(parse.(Int64,data[i-6:i,:dailyconfirmed])) for i in 7:n])
	append!(d,repeat([missing],inner=6))
	append!(d,[mean(parse.(Int64,data[i-6:i,:dailydeceased])) for i in 7:n])
	append!(e,repeat([missing],inner=6))
	append!(e,[mean(parse.(Int64,data[i-6:i,:dailyrecovered])) for i in 7:n])
	
end

# ╔═╡ fa942660-7f4b-11eb-16d9-bb7ea5dfa157
insertcols!(data,:confirmed_aggregate=>f,:deceased_aggregate=>d,:recovered_aggregate=>e)

# ╔═╡ 1ac014d0-7f4c-11eb-2b45-65f1849aa1be
begin
	plot(1:n,parse.(Int64,data.dailyconfirmed),xlabel="day",ylabel="confirmed cases",label="daily confirmed cases")
	plot!(1:n,data.confirmed_aggregate,label="moving average")
end

# ╔═╡ 2741ae30-7f4c-11eb-20a7-c59c8144564e
begin
	plot(1:n,parse.(Int64,data.dailydeceased),xlabel="day",ylabel="deceased",label="daily deceased cases")
	plot!(1:n,data.deceased_aggregate,label="moving average")
end

# ╔═╡ 349a1f90-7f4c-11eb-150e-b5b08942af1e
begin
	plot(1:n,parse.(Int64,data.dailyrecovered),xlabel="day",ylabel="recovered",label="daily recovered cases")
	plot!(1:n,data.recovered_aggregate,label="moving average")
end

# ╔═╡ Cell order:
# ╠═0152aec0-781e-11eb-379f-af444aa94b69
# ╠═f3a064c0-7f48-11eb-24ea-91db022cc794
# ╟─b442db90-7e86-11eb-1235-bb704dceadae
# ╠═c1964e6e-7e87-11eb-2192-9f20f4631900
# ╠═d1d41de0-7823-11eb-3aef-252bcd52e2b0
# ╠═a7485b40-783c-11eb-33bd-a7555e707e76
# ╠═2ab8faae-7e88-11eb-1843-1db1d1335402
# ╠═e3a5f620-7f39-11eb-27c2-b30f5340c367
# ╠═847a7260-7f3a-11eb-26f7-a1c045c1f78c
# ╠═f10031b0-7f38-11eb-12f7-598bcfa92c39
# ╠═272aec80-7f39-11eb-292d-79a2e271bc9e
# ╠═99da7140-7f3b-11eb-2420-617c48c9a303
# ╠═20774ee0-7f3b-11eb-0b4a-ef96167e2a7c
# ╠═df647e10-7f48-11eb-0066-517262ae9f4a
# ╠═314b4a10-7f49-11eb-2796-93a6038d79ff
# ╠═68290130-7f49-11eb-2694-4d63c53d7fb3
# ╠═4105d1e0-7f4a-11eb-2f41-c3da31ef2390
# ╠═57cb49a0-7f4a-11eb-09c8-1ddc72bed0dc
# ╠═fa942660-7f4b-11eb-16d9-bb7ea5dfa157
# ╠═1ac014d0-7f4c-11eb-2b45-65f1849aa1be
# ╠═2741ae30-7f4c-11eb-20a7-c59c8144564e
# ╠═349a1f90-7f4c-11eb-150e-b5b08942af1e
