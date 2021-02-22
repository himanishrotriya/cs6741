### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ b1813390-70dd-11eb-0e81-9b650278d63b
begin
	using Plots
	pyplot()
	using Random
	mean=0
	n=10000
	arr=zeros(n)
	sum=0
	for i in 1:n
		rand_num=rand(Int)
		global sum=sum+rand_num
		global mean=big(sum)/big(i)
		arr[i]=mean
	end
	plot(1:n,arr)
end

# ╔═╡ 4f38b860-70de-11eb-2ca7-5b070d99efa3
arr

# ╔═╡ Cell order:
# ╠═b1813390-70dd-11eb-0e81-9b650278d63b
# ╠═4f38b860-70de-11eb-2ca7-5b070d99efa3
