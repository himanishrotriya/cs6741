### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ ed4fef70-8f95-11eb-0d85-9b0648f188ce
using QuadGK,StatsBase,Distributions,Plots,StatsPlots,FreqTables

# ╔═╡ 1aa4cd00-9055-11eb-1b26-b7b79c147203
using CSV,DataFrames,Dates

# ╔═╡ fafe83f0-9041-11eb-341a-c92d2561f779
pyplot()

# ╔═╡ 697da380-8f96-11eb-1bea-7318c408d45e
md"# Question-1"

# ╔═╡ 159d5170-8f96-11eb-0134-f7349fff2ddf
Kl_Divergence(dist_p,dist_q)=quadgk(x->(pdf(dist_p,x)*log2(pdf(dist_p,x)/pdf(dist_q,x))),-10,10)[1]

# ╔═╡ 67f22180-8f96-11eb-2aec-c1dd22e32fc0
begin
	dist_q=Normal(0,1)
	cal_kl_divergence=[Kl_Divergence(TDist(v),dist_q) for v in 1:5]
end

# ╔═╡ f6b956e0-8f96-11eb-2d1a-873e06783aed
md"# Question-2"

# ╔═╡ 8e966eb0-9539-11eb-110a-59ee66a452e6
begin
	U = Uniform()
	step = 0.005
	range = -10:step:10
	KL_div = []
	num = 1/step + 1
end

# ╔═╡ 9b6516a0-9539-11eb-1927-e5fc27081474
function kl_diverge(p_arr, mu_q, sigma_q)
	q_arr = [pdf(Normal(mu_q, sigma_q), i) for i in range]
	KL_div_sum = 0
	for i in 1:length(range)
		if p_arr[i] > 0
			KL_div_sum += p_arr[i]*log2(p_arr[i]/q_arr[i])
		end
	end
	return KL_div_sum
end

# ╔═╡ a3012d90-9539-11eb-3b3b-d79a527bd943
function cal_arg(arr_temp)
	mu = sum([range[i]*(arr_temp[i]/(num-1)) for i in 1:length(range)])
	
	sigma = sqrt(sum([(range[i]-mu)^2*(arr_temp[i]/(num-1)) for i in 1:length(range)]))
	
	push!(KL_div, kl_diverge(arr_temp, mu, sigma))
end

# ╔═╡ b0f8ec30-9539-11eb-3e59-b9bbf23a148b
begin
	pdf_arr = [pdf(U, i) for i in range]
	cal_arg(pdf_arr)
	conv(x) = sum([pdf(U, x-i)*pdf(U, i) for i in range])
	arr_conv = conv.(range)/num
	cal_arg(arr_conv)
end

# ╔═╡ b4f742f0-9539-11eb-2e45-6169a172fa2b
begin
	arr2_conv = copy(arr_conv)
	conv2(x) = sum([pdf(U, x-range[i])*arr2_conv[i] for i in 1:length(range)])
	for j in 2:9
		global arr2_conv = conv2.(range)/num
		cal_arg(arr2_conv)
	end
end

# ╔═╡ ed06c350-9539-11eb-2086-37b08e746f0d
plot(2:10, KL_div[2:10], xlabel="n", ylabel="KL-Divergence")

# ╔═╡ be392d90-904a-11eb-090e-eb4129a99fa2
md"# Question-3"

# ╔═╡ c85ed592-904a-11eb-2ec3-052697ce5b3c
begin
	arr=[]
	append!(arr,repeat([1],1300))
	append!(arr,repeat([2],1350))
	append!(arr,repeat([3],1400))
	append!(arr,repeat([4],1460))
	append!(arr,repeat([5],1500))
	append!(arr,repeat([6],450))
	append!(arr,repeat([7],350))
	append!(arr,repeat([8],250))
	append!(arr,repeat([9],200))
	append!(arr,repeat([10],120))
	append!(arr,repeat([11],70))
	append!(arr,repeat([12],50))
	append!(arr,repeat([13],30))
	append!(arr,repeat([14],10))
	append!(arr,repeat([15],5))
end

# ╔═╡ 045138a0-9531-11eb-2cec-293a52dc0f61
mean(arr)

# ╔═╡ e1c7bd10-904c-11eb-2589-05db554ee23b
median(arr)

# ╔═╡ 025e70b0-904c-11eb-034d-e9b39666bd87
begin
	histogram(arr,nbins=15,fill=0.5,label=false)
	plot!([mean(arr),mean(arr)],[0,1500],line=(2,:black),label="mean")
	plot!([median(arr),median(arr)],[0,1500],line=(2,:yellow),label="median")
	plot!([mode(arr),mode(arr)],[0,1500],line=(2,:red),label="mode")
end

# ╔═╡ 715189b0-904e-11eb-2394-3fe69b715966
md"# Question-4"

# ╔═╡ 1b7de890-952f-11eb-033d-c7eb96b1d0bf
begin
	num_samples=10000
	sample_arr=[rand(Uniform(0,1),30) for _ in 1:10000]
	sample_range=maximum.(sample_arr)-minimum.(sample_arr)
	num_bins=50
	bin_freq=zeros(num_bins)
	bin_width=1/num_bins
	bin_sum=zeros(num_bins)
	for i in 1:length(sample_range)
		idx=Integer(floor(sample_range[i]/bin_width))+1
		bin_freq[idx]+=1
		bin_sum[idx]+=sample_range[i]
	end
	bin_avg=[(bin_freq[i]==0) ? 0 : bin_sum[i]/bin_freq[i] for i in 1:length(bin_sum)]
end

# ╔═╡ 4de3d330-952f-11eb-3cab-4d3eb2e42c7d
function median_(bin_avg,bin_freq)
	idx1=0
	idx2=0
	flag=false
	for i in 1:num_bins
		cum_freq=cumsum(bin_freq)
		if cum_freq[i]>=num_samples/2 && flag==false
			idx1=i
			flag=true
		end
		if cum_freq[i]>=(num_samples/2+1)
			idx2=i
			break
		end
	end
		return mean([bin_avg[idx1],bin_avg[idx2]])
end

# ╔═╡ 5396b7c0-952f-11eb-2087-ef22786bbfec
function mode_(bin_avg,bin_freq)
	idx=argmax(bin_freq)
	return bin_avg[idx]
end

# ╔═╡ 6a851440-952f-11eb-0cb7-87951561b58b
mean_(bin_avg,bin_freq)=sum(bin_avg.*bin_freq)/(sum(bin_freq)-1)

# ╔═╡ 7704d8e0-952f-11eb-0b00-5357303cd258
begin
	mean_s=mean_(bin_avg,bin_freq)
	median_s=median_(bin_avg,bin_freq)
	mode_s=mode_(bin_avg,bin_freq)
	histogram(sample_range,nbins=20,label=false)
	plot!([mode_s,mode_s],[0,2500],line=(2,:dash,:red),label="mode")
	plot!([median_s,median_s],[0,2500],line=(2,:dash,:green),label="median")
	plot!([mean_s,mean_s],[0,2500],line=(2,:dash,:yellow),label="mean",legend=:topleft)
end

# ╔═╡ 827613b0-952f-11eb-068a-2571612b26c5
[mean_(bin_avg,bin_freq) median_(bin_avg,bin_freq) mode_(bin_avg,bin_freq)]

# ╔═╡ 14295dc0-9054-11eb-2781-f148f7db779a
md"# Question-6"

# ╔═╡ da24e520-93ca-11eb-048c-3fc9042af7f8
df=CSV.read(download("https://api.covid19india.org/csv/latest/states.csv"),DataFrame)

# ╔═╡ bf6f5810-9054-11eb-1a35-4da8f8edc08a
function convert_week(x)
	if (Dates.year(x)==2021 && Dates.week(x)<53)
			return (Dates.week(x)+53-4)
	end
	return Dates.week(x)-4
end

# ╔═╡ cee1a8c0-9054-11eb-1da9-994ccc025d86
select!(df,:Date,:Date=>(x->convert_week.(x))=>:Week,Not([:Date]))

# ╔═╡ 5f8a6f60-9055-11eb-355d-dddc6f98fffa
state_df=unstack(combine(groupby(df,[:Week,:State]),:Confirmed=>sum),:State,:Confirmed_sum)

# ╔═╡ 75114ca0-9055-11eb-2a4d-89bd7f6b67d7
begin
	for i in 2:ncol(state_df)
	    state_df[:,i]=replace!(x->ismissing(x) ? 0 : x,state_df[:,i])
	end
	state_df
end

# ╔═╡ 7e648790-93c5-11eb-1216-cb335d161058
select!(state_df,Not([Symbol("State Unassigned"),:India]))

# ╔═╡ 85017fe0-9055-11eb-0df8-c198d2fa98d9
function covmat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = cov(collect(sx), collect(sy))
	   end
   end
   return t
   end;

# ╔═╡ 88a77d70-9055-11eb-0250-a92938627fcc
function cormat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = cor(collect(sx), collect(sy))
			sx
	   end
   end
   return t
   end;

# ╔═╡ ba04a342-9058-11eb-3886-4b31c69a14d5
function corspearmanmat(df)
   nc = ncol(df)
   t = zeros(nc, nc)
   for (i, c1) in enumerate(eachcol(df))
	   for (j, c2) in enumerate(eachcol(df))
		   sx, sy = skipmissings(c1, c2)
		   t[i, j] = corspearman(collect(sx), collect(sy))
	   end
   end
   return t
   end;

# ╔═╡ f45205b0-9058-11eb-3351-15bda002880c
covv=covmat(select(state_df,Not([:Week])))

# ╔═╡ 279dbc72-9059-11eb-2de3-370136080646
corr=cormat(select(state_df,Not([:Week])))

# ╔═╡ 33f845d0-9059-11eb-3f6f-3ffc9193e58c
corrspearman=corspearmanmat(select(state_df,Not([:Week])))

# ╔═╡ f0616f10-93d0-11eb-1b74-199f825d734a
name=names(state_df)[2:ncol(state_df)]

# ╔═╡ 1bad711e-905a-11eb-18ed-77414ae9e71a
pyplot()

# ╔═╡ a79ac800-9059-11eb-2493-310d59e4a091
default(size=(800,500))

# ╔═╡ 6007dff2-9059-11eb-24be-5f9328aea942
heatmap(name,name,covv)

# ╔═╡ 3d4d3ae0-905a-11eb-2803-857f2c2387ba
heatmap(name,name,corr)

# ╔═╡ 5443adb0-905a-11eb-3925-c7be17cc4cd8
heatmap(name,name,corrspearman)

# ╔═╡ 5fd82190-9534-11eb-2a3e-858093baade0
md"# Question-7"

# ╔═╡ b35ebae0-9534-11eb-0e23-5768f2fb7754
function onesidedtail(Dist,x)
	cdf_n(Dist,z) = cdf(Dist, z)
	cdf_n_inv(Dist,u) = minimum(filter((x) -> (cdf_n(Dist,x) >= u), -10:0.01:10))
	return cdf_n_inv(Dist,1-x)
end
	

# ╔═╡ b6e597b0-9534-11eb-3074-f3a7ee25f85a
begin
	dist_n=Normal(0,1)
	dist_t=TDist(10)
	ost_dist_n=[onesidedtail(dist_n,x) for x in 0.01:0.005:0.99]
	ost_dist_t=[onesidedtail(dist_t,x) for x in 0.01:0.005:0.99]
	plot(1:0.5:99,ost_dist_n,label="Normal Distribution")
	plot!(1:0.5:99,ost_dist_t,label="T Distribution")
end

# ╔═╡ 17b5ae40-9535-11eb-210e-87c9fe53db2a
begin
	plot(x->x, x->pdf(Normal(0, 1), x), -10, 10, label="Normal Distribution",fill=(0,:blue,0.5))
	plot!(x->x, x->pdf(TDist(10), x), -10, 10, label="T-Dist",fill=(0,:red,0.7))
	
	plot!(x->x, x->pdf(Normal(0, 1), x), -10, onesidedtail(Normal(0,1),0.95), fill=(0, :yellow), label="one_sided_tail_NormalDist")
	plot!(x->x, x->pdf(TDist(10),x),-10, onesidedtail(TDist(10),0.95), fill=(0, :green), label="one_sided_tail_TDist")
end

# ╔═╡ 22ec5110-9535-11eb-3665-0b3d9a3e341f
onesidedtail(Normal(0,1),0.95)

# ╔═╡ 245d9450-9535-11eb-1de0-cfa74e09b694
onesidedtail(TDist(10),0.95)

# ╔═╡ Cell order:
# ╠═ed4fef70-8f95-11eb-0d85-9b0648f188ce
# ╠═1aa4cd00-9055-11eb-1b26-b7b79c147203
# ╠═fafe83f0-9041-11eb-341a-c92d2561f779
# ╠═697da380-8f96-11eb-1bea-7318c408d45e
# ╠═159d5170-8f96-11eb-0134-f7349fff2ddf
# ╠═67f22180-8f96-11eb-2aec-c1dd22e32fc0
# ╠═f6b956e0-8f96-11eb-2d1a-873e06783aed
# ╠═8e966eb0-9539-11eb-110a-59ee66a452e6
# ╠═9b6516a0-9539-11eb-1927-e5fc27081474
# ╠═a3012d90-9539-11eb-3b3b-d79a527bd943
# ╠═b0f8ec30-9539-11eb-3e59-b9bbf23a148b
# ╠═b4f742f0-9539-11eb-2e45-6169a172fa2b
# ╠═ed06c350-9539-11eb-2086-37b08e746f0d
# ╠═be392d90-904a-11eb-090e-eb4129a99fa2
# ╠═c85ed592-904a-11eb-2ec3-052697ce5b3c
# ╠═045138a0-9531-11eb-2cec-293a52dc0f61
# ╠═e1c7bd10-904c-11eb-2589-05db554ee23b
# ╠═025e70b0-904c-11eb-034d-e9b39666bd87
# ╠═715189b0-904e-11eb-2394-3fe69b715966
# ╠═1b7de890-952f-11eb-033d-c7eb96b1d0bf
# ╠═4de3d330-952f-11eb-3cab-4d3eb2e42c7d
# ╠═5396b7c0-952f-11eb-2087-ef22786bbfec
# ╠═6a851440-952f-11eb-0cb7-87951561b58b
# ╠═7704d8e0-952f-11eb-0b00-5357303cd258
# ╠═827613b0-952f-11eb-068a-2571612b26c5
# ╠═14295dc0-9054-11eb-2781-f148f7db779a
# ╠═da24e520-93ca-11eb-048c-3fc9042af7f8
# ╠═bf6f5810-9054-11eb-1a35-4da8f8edc08a
# ╠═cee1a8c0-9054-11eb-1da9-994ccc025d86
# ╠═5f8a6f60-9055-11eb-355d-dddc6f98fffa
# ╠═75114ca0-9055-11eb-2a4d-89bd7f6b67d7
# ╠═7e648790-93c5-11eb-1216-cb335d161058
# ╠═85017fe0-9055-11eb-0df8-c198d2fa98d9
# ╠═88a77d70-9055-11eb-0250-a92938627fcc
# ╠═ba04a342-9058-11eb-3886-4b31c69a14d5
# ╠═f45205b0-9058-11eb-3351-15bda002880c
# ╠═279dbc72-9059-11eb-2de3-370136080646
# ╠═33f845d0-9059-11eb-3f6f-3ffc9193e58c
# ╠═f0616f10-93d0-11eb-1b74-199f825d734a
# ╠═1bad711e-905a-11eb-18ed-77414ae9e71a
# ╠═a79ac800-9059-11eb-2493-310d59e4a091
# ╠═6007dff2-9059-11eb-24be-5f9328aea942
# ╠═3d4d3ae0-905a-11eb-2803-857f2c2387ba
# ╠═5443adb0-905a-11eb-3925-c7be17cc4cd8
# ╠═5fd82190-9534-11eb-2a3e-858093baade0
# ╠═b35ebae0-9534-11eb-0e23-5768f2fb7754
# ╠═b6e597b0-9534-11eb-3074-f3a7ee25f85a
# ╠═17b5ae40-9535-11eb-210e-87c9fe53db2a
# ╠═22ec5110-9535-11eb-3665-0b3d9a3e341f
# ╠═245d9450-9535-11eb-1de0-cfa74e09b694
