### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 59641420-a7f1-11eb-2e5f-83ea9e28af4b
using Plots,Distributions

# ╔═╡ fe852e32-a7f1-11eb-2eb2-8ff8a49f01fa
pyplot()

# ╔═╡ afbebf90-a7f2-11eb-173c-afce516c4fd6
begin
	n=1
	mean_ss=100
	std_ss=30
	while true
		u=Normal(n*mean_ss,sqrt(n)*std_ss)
		if (1-cdf(u,3000))>=0.95
			break
		end
		n+=1
	end
	
end
	

# ╔═╡ ae211f60-b0a9-11eb-0033-531db7077d00
md"# minimum number of suits required=$n"

# ╔═╡ Cell order:
# ╠═59641420-a7f1-11eb-2e5f-83ea9e28af4b
# ╠═fe852e32-a7f1-11eb-2eb2-8ff8a49f01fa
# ╠═afbebf90-a7f2-11eb-173c-afce516c4fd6
# ╠═ae211f60-b0a9-11eb-0033-531db7077d00
