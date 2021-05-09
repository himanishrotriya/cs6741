### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 7be8d79e-b0ad-11eb-3b66-99f755008fef
begin
	using Distributions
	using Random
	using Statistics
	using StatsPlots
	using Plots
	plotly()
end

# ╔═╡ a01cc450-b0ae-11eb-1603-2d7bb715c799
function Temp(Dist)
	Random.seed!(10)
	mu = mean(Dist)
	sd = std(Dist)
	D_N = Normal(0, 1)
	
	for n in 1:500
		sample_set = []
		for k in 1:50000
			X = rand(Dist, n)
			s_n = sqrt(n)*sd
			X = (X.-mu)./s_n
			push!(sample_set, sum(X))
		end
        global Y=convert(Array{Float64,1}, sample_set)
		diff_m3 = abs(skewness(Y) - skewness(D_N))
		diff_m4 = abs(kurtosis(Y) - kurtosis(D_N))
		if(diff_m3 <= 0.1 && diff_m4 <= 0.1)
			return n, Y
		end
	end
end

# ╔═╡ 6f9054a0-b0ae-11eb-3ecf-99ae8ca3aad6
begin
	n1, sample_set1 = Temp(Uniform(0, 1))
	density(sample_set1)
end

# ╔═╡ 12e8476e-b0af-11eb-2da3-733812cc9563
begin
	n2, sample_set2 = Temp(Binomial(99, 0.01))
	density(sample_set2)
end

# ╔═╡ 2ecdb290-b0af-11eb-1ebd-c1c1354283f9
begin
	n3, sample_set3 = Temp(Binomial(99, 0.5))
	density(sample_set3)
end

# ╔═╡ ef65b3f0-b0ae-11eb-2f32-5508c38766e6
begin
	n4, sample_set4 = Temp(Chisq(3))
	density(sample_set4)
end

# ╔═╡ d729e680-b0c7-11eb-18dd-5b26d2c41c30
a = [n1, n2, n3, n4]

# ╔═╡ Cell order:
# ╠═7be8d79e-b0ad-11eb-3b66-99f755008fef
# ╠═a01cc450-b0ae-11eb-1603-2d7bb715c799
# ╠═6f9054a0-b0ae-11eb-3ecf-99ae8ca3aad6
# ╠═12e8476e-b0af-11eb-2da3-733812cc9563
# ╠═2ecdb290-b0af-11eb-1ebd-c1c1354283f9
# ╠═ef65b3f0-b0ae-11eb-2f32-5508c38766e6
# ╠═d729e680-b0c7-11eb-18dd-5b26d2c41c30
