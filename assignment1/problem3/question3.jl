### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ d2860030-732a-11eb-1ba7-cbafc47c6173
begin
	using Plots
	using Random
	using Distributions
	pyplot()
	cards=shuffle!(repeat(1:13,4))
end

# ╔═╡ 111ca50e-732b-11eb-0c94-1b1fb0cce2d9
begin
	n1=zeros(6)
	for i in 0:5
		n1[i+1]=pdf(Binomial(5,4/52),i)
	end
end

# ╔═╡ efc9b460-743e-11eb-1e6c-7152ede8da69
begin
	println("####### with replacement #####")
	for i in 0:5
		println("n=",i,"      ","probability=",n1[i+1])
	end
end

# ╔═╡ f00d7f4e-73ea-11eb-0032-75fdd188ea10
begin
	plot(0:5,n1,line=:stem,marker=:circle,label="Binomial Distribution(with replacement)",xlabel="n",ylabel="Probability of picking n jacks")
end

# ╔═╡ 9a652540-732b-11eb-059e-33b2559f0428
begin
	n2=zeros(5)
	for i in 0:4
		n2[i+1]=pdf(Hypergeometric(4,48,5),i)
	end
end

# ╔═╡ 21cac2b0-743f-11eb-29fc-a10311b5596b
begin
	println("####### without replacement #####")
	for i in 0:4
		println("n=",i,"      ","probability=",n2[i+1])
	end
end

# ╔═╡ 862c6fa0-73eb-11eb-387a-d5a325501086
plot(0:4,n2,line=:stem,marker=:circle,label="Hypergeometric Distribution(without replacement)",xlabel="n",ylabel="Probability of picking n jacks")

# ╔═╡ Cell order:
# ╠═d2860030-732a-11eb-1ba7-cbafc47c6173
# ╠═111ca50e-732b-11eb-0c94-1b1fb0cce2d9
# ╠═efc9b460-743e-11eb-1e6c-7152ede8da69
# ╠═f00d7f4e-73ea-11eb-0032-75fdd188ea10
# ╠═9a652540-732b-11eb-059e-33b2559f0428
# ╠═21cac2b0-743f-11eb-29fc-a10311b5596b
# ╠═862c6fa0-73eb-11eb-387a-d5a325501086
