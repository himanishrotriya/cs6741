### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 0866f500-71b0-11eb-3803-5fb316d6c3c2
begin
	using Distributions
	using Plots
	pyplot()
end

# ╔═╡ 7198fbd0-71b6-11eb-27c1-d1c5c6b253a3
begin
	n=1000000
	prob=[]
	for i in 0:20
		p=i/20
		count=0
	    for _ in 1:n
			amount=10
		    for _ in 1:20
				if rand()<=1-p
					amount+=1
				else
					amount-=1
				end
			end
			if amount>=10
				count+=1
			end
		end
		count=count/n
		push!(prob,count)
		
	end
end
			
		
		

# ╔═╡ 80a97512-7435-11eb-2cb1-9f893a9694c0
begin
	plot([i/20 for i in 0:20],prob,line=:stem,marker=:circle,xlabel="p",ylabel="Required Probabilty",legend=false)
end

# ╔═╡ 0a570430-71bb-11eb-2900-67205b0f5b9e
begin
	
	for i in 0:20
		println("p=",(i/20),"          ","Required Probability=",prob[i+1])
	end
end
	

# ╔═╡ Cell order:
# ╠═0866f500-71b0-11eb-3803-5fb316d6c3c2
# ╠═7198fbd0-71b6-11eb-27c1-d1c5c6b253a3
# ╠═80a97512-7435-11eb-2cb1-9f893a9694c0
# ╠═0a570430-71bb-11eb-2900-67205b0f5b9e
