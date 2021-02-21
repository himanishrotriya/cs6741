### A Pluto.jl notebook ###
# v0.12.20

using Markdown
using InteractiveUtils

# ╔═╡ e8e4c620-6db4-11eb-1bca-91beeb3dbe4a
begin
	p=1-((77^8)+8*(77^7))/(78^8)
	println("Theoretical answer=",p)
end

# ╔═╡ b58f1682-70e4-11eb-2d2c-b3a610a137f3
begin
	d=1:78
	n=100000
	actual_password=rand(d,8)
	match=0
	for i in 1:n
		random_password=rand(d,8)
		flag=sum([random_password[i]==actual_password[i] for i in 1:8])>1
		if flag==true
			match+=1
		end
	end
	match=match/n
end

# ╔═╡ 00a3b5f0-7440-11eb-21ab-7d6349334eec
begin
	println("Answer from experiment=",match)
end

# ╔═╡ Cell order:
# ╠═e8e4c620-6db4-11eb-1bca-91beeb3dbe4a
# ╠═b58f1682-70e4-11eb-2d2c-b3a610a137f3
# ╠═00a3b5f0-7440-11eb-21ab-7d6349334eec
