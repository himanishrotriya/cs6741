### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 7da25960-b0ab-11eb-3e2b-b127410a1fad
using Distributions,PlutoUI,Random

# ╔═╡ 2ef713e0-b0ac-11eb-2a7f-499a60b525f3
md"# CLT"

# ╔═╡ 655c8330-b0ab-11eb-33e7-69b40d29d285
function compute_head_probability()
    temp_p=0
    p1=0.5
    while (temp_p<=0.5)
   	 clt_dist=Normal(50*p1,sqrt(50)*sqrt(p1*(1-p1)))
   	 temp_p=cdf(clt_dist,50)-cdf(clt_dist,29.5)
   	 p1=p1+0.00000001
    end
    return p1
end


# ╔═╡ 72c39a90-b0ab-11eb-3c1d-7b4e934390c9
begin
	p1=compute_head_probability()
	with_terminal() do
		print("the value of heads probability for which probability of going ahead with our decision is greater than 0.5 is:",p1)
	end
end


# ╔═╡ 3759af20-b0ac-11eb-22b3-7178617b6d78
md"# Monte-Carlo Simulation"

# ╔═╡ 42645ff0-b0ac-11eb-11f7-1b7be7943883
begin
	Random.seed!(1)
	dist_mc=Bernoulli(p1)
	mc_outcome_clt=sum.([rand(dist_mc,50).*1 for i in 1:10000])
	prob_mc_clt=length(mc_outcome_clt[mc_outcome_clt.>=30])/length(mc_outcome_clt)
	with_terminal() do
		print("using monte carlo simulation the probability of going ahead with decision is:",prob_mc_clt)
	end
end


# ╔═╡ 63e8d980-b0ac-11eb-345e-91c20adf2630
md"# Binomial-Distribution"

# ╔═╡ 747c2a90-b0ac-11eb-3092-e7412d51ebb8

begin
	p=p1
	sum_init1=0
	for i in 30:50
		sum_init1=sum_init1+binomial(50,i)*p^(i)*(1-p)^(50-i)
	end
	with_terminal() do
		print("using binomial distribution the probability of going ahead with decision is:",sum_init1)
	end
end



# ╔═╡ Cell order:
# ╠═7da25960-b0ab-11eb-3e2b-b127410a1fad
# ╠═2ef713e0-b0ac-11eb-2a7f-499a60b525f3
# ╠═655c8330-b0ab-11eb-33e7-69b40d29d285
# ╠═72c39a90-b0ab-11eb-3c1d-7b4e934390c9
# ╠═3759af20-b0ac-11eb-22b3-7178617b6d78
# ╠═42645ff0-b0ac-11eb-11f7-1b7be7943883
# ╠═63e8d980-b0ac-11eb-345e-91c20adf2630
# ╠═747c2a90-b0ac-11eb-3092-e7412d51ebb8
