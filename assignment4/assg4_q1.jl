### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ cb758b30-b0a6-11eb-1b31-5bea9267703a
using Distributions

# ╔═╡ e7f6e830-b0a6-11eb-0f7b-3fada8b215a3
md"# Monte-Carlo Simulation "

# ╔═╡ 205090f2-b0a7-11eb-3cd5-01e8831e0be5
begin
    num_trials=100000
	monte_carlo=sum.([rand([0,1],50)  for j in 1:num_trials])
	prob_monte_carlo=length(monte_carlo[monte_carlo.>=30])/length(monte_carlo)
end



# ╔═╡ 8a65fa40-b0aa-11eb-29f7-4783f6b3b99b
md"# Binomial-Distribution"

# ╔═╡ 94609aa0-b0aa-11eb-2df4-63c1c904e140
begin
	sum_init=0
	for i in 30:50
		sum_init=sum_init+binomial(50,i)
	end
	sum_init=sum_init*(0.5)^50
end




# ╔═╡ d5cb6e20-b0aa-11eb-1fa2-859867a7a258
md"# Approximation using clt"

# ╔═╡ 15afefc0-b0ab-11eb-091e-8d7c5fd66c53
begin
	dist=Normal(25,0.5*sqrt(50))
	cdf(dist,50)-cdf(dist,29.5)
end


# ╔═╡ Cell order:
# ╠═cb758b30-b0a6-11eb-1b31-5bea9267703a
# ╠═e7f6e830-b0a6-11eb-0f7b-3fada8b215a3
# ╠═205090f2-b0a7-11eb-3cd5-01e8831e0be5
# ╠═8a65fa40-b0aa-11eb-29f7-4783f6b3b99b
# ╠═94609aa0-b0aa-11eb-2df4-63c1c904e140
# ╠═d5cb6e20-b0aa-11eb-1fa2-859867a7a258
# ╠═15afefc0-b0ab-11eb-091e-8d7c5fd66c53
