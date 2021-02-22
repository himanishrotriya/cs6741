### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 1d952190-71c9-11eb-0af1-dfd06ec5db89
begin
	using Distributions
	using Plots
	pyplot()
end

# ╔═╡ 88479590-71c9-11eb-31f9-0f1815d9d9e4
begin
	n=100000
	prob=[]
	for i in 0:20
		p=i/20
		count1=0
		count2=0
		for _ in 1:n
			flag=false
			amount=10
			for _ in 1:20
				if rand()<=1-p
					amount+=1
				else
					amount-=1
				end
				if amount==0
					flag=true
					break
				end
			end
			if flag==false
				count2+=1
			end
			if amount>=10
				count1+=1
			end
		end
		push!(prob,count1/count2)
	end
end
				

# ╔═╡ 2ddbc422-7438-11eb-0248-11fd41c31ce3
prob

# ╔═╡ 0fa90fa2-7422-11eb-13df-87cb3fc285a0
begin
	plot([i/20 for i in 0:20],prob,line=:stem,marker=:circle,xlabel="p",ylabel="Required Conditional Probability",legend=false)
end

# ╔═╡ 4d92828e-7438-11eb-0c1b-bfa62220c90f
begin
	for i in 0:20
		println("p=",i/20,"     ","Required Conditional Probability=",prob[i+1])
	end
end

# ╔═╡ Cell order:
# ╠═1d952190-71c9-11eb-0af1-dfd06ec5db89
# ╠═88479590-71c9-11eb-31f9-0f1815d9d9e4
# ╠═2ddbc422-7438-11eb-0248-11fd41c31ce3
# ╠═0fa90fa2-7422-11eb-13df-87cb3fc285a0
# ╠═4d92828e-7438-11eb-0c1b-bfa62220c90f
