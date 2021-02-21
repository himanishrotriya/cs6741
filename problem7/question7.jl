### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 3918de50-71c1-11eb-1b31-e5a1d8e46ede
begin
	using Distributions
	using Plots
	pyplot()
end

# ╔═╡ cc5460f2-71c5-11eb-0c84-716e69110e58
begin
	n=100000
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
				if amount==0
					count+=1
					break
				end
			end
		end
		count=count/n
		push!(prob,count)
	end
end

# ╔═╡ f7436eb0-741c-11eb-3e00-47ade979180a
begin
     plot([i/20 for i in 0:20],prob,line=:stem,marker=:circle,xlabel="p",ylabel="Probability of going bankrupt(atleast once)",legend=false)
end

# ╔═╡ 2667c410-7437-11eb-037f-2f8e44b33a83
begin
	for i in 0:20
		println("p=",i/20,"       ","Required Probability=",prob[i+1])
	end
end

# ╔═╡ Cell order:
# ╠═3918de50-71c1-11eb-1b31-e5a1d8e46ede
# ╠═cc5460f2-71c5-11eb-0c84-716e69110e58
# ╠═f7436eb0-741c-11eb-3e00-47ade979180a
# ╠═2667c410-7437-11eb-037f-2f8e44b33a83
