### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ 154a92a0-6d1d-11eb-0c90-f9bf686d3b1f
begin
	using StatsBase
	using Plots
	using Random
	pyplot()
	cards=shuffle!(repeat(1:13,4))
end

# ╔═╡ 6aa0eb00-6dae-11eb-1c01-312409379b4b
using Distributions

# ╔═╡ 96539ab0-6d43-11eb-274f-addd38d9f5ec
begin
	n1=zeros(6)
	num = 1000000
	for i in 1:num
	    c=count([rand(cards),rand(cards),rand(cards),rand(cards),rand(cards)].==11)
		n1[c+1]=n1[c+1]+1
	end
	n1=n1/num
end

# ╔═╡ 1ff3d042-6d22-11eb-1c12-6b4b16873c30
begin
	n2=zeros(5)
	for i in 1:num
		count=0
		cards1=copy(cards)
		for j in 1:5
			card=rand(cards1)
		    deleteat!(cards1, findfirst(x-> x ==card, cards1))
		    if card==11
				count=count+1
			end
		end
		n2[count+1]=n2[count+1]+1
	end
	n2=n2/num
end

# ╔═╡ a9d3cff0-743d-11eb-1547-7f21cd65135f
begin
	println("####### with replacement #####")
	for i in 0:5
		println("n=",i,"      ","probability=",n1[i+1])
	end
end

# ╔═╡ bd0feff0-73e7-11eb-30f0-4bbe03a94358
begin
	plot(0:5,n1,line=:stem,marker=:circle,label="with replacement",xlabel="n",ylabel="Probability of picking n jacks")
end

# ╔═╡ 417b8320-743e-11eb-3db1-c9a2ec8fa000
begin
	println("####### without replacement #####")
	for i in 0:4
		println("n=",i,"      ","probability=",n2[i+1])
	end
end

# ╔═╡ d85104c0-73e7-11eb-078b-8715c15b5102
begin
	plot(0:4,n2,line=:stem,marker=:circle,label="without replacement",xlabel="n",ylabel="Probability of picking n jacks")
end

# ╔═╡ Cell order:
# ╠═154a92a0-6d1d-11eb-0c90-f9bf686d3b1f
# ╠═6aa0eb00-6dae-11eb-1c01-312409379b4b
# ╠═96539ab0-6d43-11eb-274f-addd38d9f5ec
# ╠═1ff3d042-6d22-11eb-1c12-6b4b16873c30
# ╠═a9d3cff0-743d-11eb-1547-7f21cd65135f
# ╠═bd0feff0-73e7-11eb-30f0-4bbe03a94358
# ╠═417b8320-743e-11eb-3db1-c9a2ec8fa000
# ╠═d85104c0-73e7-11eb-078b-8715c15b5102
