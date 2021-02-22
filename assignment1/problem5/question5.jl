### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 85128120-70eb-11eb-2a96-1bac49c73576
begin
	using Plots
	pyplot()
	using Distributions
end

# ╔═╡ 484bd6c0-70ea-11eb-0d38-33e15dcf2e5c
begin
	wanted_probability=10^3/10^6
	p=1/78
	n_match=0
	for i in 1:8
		prob=0
		for j in 0:i-1
			prob=prob+binomial(8,j)*p^j*(1-p)^(8-j)
		end
		prob=1-prob
		if (prob<=wanted_probability)
			global n_match=i
			break;
		end
	end
end

# ╔═╡ c18b6e80-73fe-11eb-2bdf-63771c957061
begin
    println("Password should be stored in database if atleast ",n_match," characters match")
end

# ╔═╡ b78c8572-70ea-11eb-0ca4-fdcc07112121
begin
	plot([1:8],[(1-cdf(Binomial(8,1/78),x)) for x in 0:7],ylim=(0,0.008),line=:stem,marker=:circle,legend=false)
end

# ╔═╡ fbcdf0f0-73fd-11eb-2006-1fce227194d0
begin
	for i in 1:8
		prob=1-cdf(Binomial(8,p),i-1)
		if (prob<=wanted_probability)
			println("$i")
			break;
		end
	end
end

# ╔═╡ Cell order:
# ╠═85128120-70eb-11eb-2a96-1bac49c73576
# ╠═484bd6c0-70ea-11eb-0d38-33e15dcf2e5c
# ╠═c18b6e80-73fe-11eb-2bdf-63771c957061
# ╠═b78c8572-70ea-11eb-0ca4-fdcc07112121
# ╠═fbcdf0f0-73fd-11eb-2006-1fce227194d0
