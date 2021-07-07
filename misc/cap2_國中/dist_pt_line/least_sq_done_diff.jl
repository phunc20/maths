### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 32ec40ec-df19-11eb-3b93-831604ef09c6
begin
  using Pkg
  #Pkg.activate(Base.Filesystem.homedir() * "git-repos")
  Pkg.activate("../../../.julia_envs/oft")
  Pkg.add("Plots")
  Pkg.add("PlutoUI")
  Pkg.add("LaTeXStrings")
  using Plots
  using Random
  using PlutoUI
  using LaTeXStrings
end

# ╔═╡ 4d813b8c-dd9e-11eb-1131-7d43433427ed
md"""
# Least Squares Done Differently
我原本是在做這個 **_"有點不一樣的最小平方差 "_** 的推導; 期間發現一個可以說是國中數學的東西. 因爲自己國中數學學得 lý ly lác lạc, 這部分當初也沒有弄得清楚, 所以想說把它寫下來, 看看有沒有可能造福現在或未來的國中生.

想法是這樣的, 原本的, 最基本的最小平方差 (least square errors) 問題是,  在二維平面 ``\mathbb{R}^2`` 上, 有一堆點 ``(x_{k}, y_{k}), k = 1, \ldots, n,\,`` 我們試圖找出一條直線 ``L: ax + by = c`` 使得各個點 ``(x_{k}, y_{k})`` 的 ``y`` 方向的投影距離平方的和最小.
"""

# ╔═╡ 0c155fae-df27-11eb-141f-b1643d8eedd1
epsilon = 1e-6

# ╔═╡ ec857128-df1d-11eb-0385-85e189ae94ab
function line_fn(a, b, c)
  function ordinate(x)
    # ordinate simply means y (as opposed to x, which is abscissa)
    return (c - a*x) / (b + epsilon)
  end
  return ordinate
end

# ╔═╡ 8e8bb7fa-df20-11eb-3b6b-7953e25fa4ae
begin
  rng = MersenneTwister(20)
  n_instances = 30
  X = rand(rng, Float32, n_instances)
  # smaller slope (i.e. a) implies easier visualization
  a, b, c = -1.234, 1., π
  y = line_fn(a, b, c).(X)
  xs = [-0.5, 1.5]
  ys = line_fn(a,b,c).(xs)
  # straight line
  plot(xs, ys,
       aspect_ratio=:equal,
       legend=false,
       xlims=xs,
       #size=(10,10),
       xlabel=L"x",
       ylabel=L"y",
  )
  noise = 0.5*randn(rng, Float32, length(X))
  noisy = y + noise
  # projections
  for i in 1:length(X)
    plot!([X[i], X[i]], [y[i], noisy[i]], color="orange")
  end
  markersize = 3
  # points
  scatter!(X, noisy,
           #marker="x",
           markersize=markersize,
  )
  #plot!(size=(800, 800))
end

# ╔═╡ a5d5b1e4-df17-11eb-3894-493f14794266
md"""
如果我們只找**_斜線_** 的話 (亦即只在 ``ax + by = c,\; b  \neq 0`` 之中找合適的直線), 那麼我們剛纔所說的問題相當於
```math
\min_{a,\,b,\,c} \left(\sum_{k=1}^{n} \,\lvert y_{k} - \frac{c - ax_{k}}{b} \rvert^{2} \right)\,.
```

對於上述的問題, 網路上書本裏很多的討論, 也被視作很基本的數學. 至於我想做的推導, 也不是很有新意, 只是更年輕的時候就有想過或看到過, 但一直沒有花時間把它弄明白: 與其用 ``y`` 方向的投影距離, 爲何我們不直接用各點 ``(x_{k}, y_{k})`` 到直線的距離和 (或距離平方和), 然後尋找最小化這個和的直線?
"""

# ╔═╡ 2a8af174-df27-11eb-1f6e-1592ce0e8452
function normal(x, y, a, b, c)
  return (-(a*x + b*y - c) / (a^2 + b^2 + epsilon)) * [a, b]
end

# ╔═╡ cde3dc82-df27-11eb-23a1-4110a17de198
begin
  # straight line
  plot(xs, ys,
       legend=false,
       aspect_ratio=:equal,
       xlims=xs,
       xlabel=L"x",
       ylabel=L"y",
  )
  #xlabel("x")
  # projections
  for i in 1:length(X)
    x_proj, y_proj = [X[i], noisy[i]] + normal(X[i], noisy[i], a, b, c)
    plot!([X[i], x_proj], [noisy[i], y_proj], color="lime")
  end
  # points
  scatter!(X, noisy,
           #marker="x",
           markersize=markersize,
  )
end


# ╔═╡ e046a8aa-df22-11eb-0305-4b844ab449d0
md"""
如果把 ``d_{L}: (x, y) \in \mathbb{R}^2 \mapsto \mathbb{R}`` 定義爲將平面上各點打到該點到直線 ``L`` 的距離的函數, 那麼我們要探討的問題就相當於
```math
\begin{align}
&\min_{L} \left(\sum_{k=1}^{n} \,d_{L}(x_k, y_k)^{p} \right)\quad \text{亦即} \\
&\min_{a,\,b,\,c} \left(\sum_{k=1}^{n} \,d_{L:\,ax + by = c}(x_k, y_k)^{p} \right)\,,
\end{align}
```
其中 ``p`` 可以是 ``1`` 或 ``2`` 或 其他正整數 ``\;``(就看哪一個對我們而言容易計算).
"""

# ╔═╡ 98155677-1c37-4a4c-ae51-704c9bab9083
md"""
## 所以..., 國中的問題在哪裏?
嗯, 抱歉, 前情提要拖得有點長. 國中數學的部分就在於
> 如何找平面上給定一點 ``(x_0, y_0)`` 到一給定直線 ``L: ax + by = c`` 的距離.

換句話說, 也就是在找上面提到的函數 ``d_L\,.``
"""

# ╔═╡ cb035256-df20-11eb-2734-1fabc3195fd5


# ╔═╡ cae22a2c-df20-11eb-3ff1-bb7e88c9c96f


# ╔═╡ cabb3598-df20-11eb-13cd-c18f5447e8f2
with_terminal() do
for (i, x) in enumerate(X)
  dump(i)
  dump(x)
end
end

# ╔═╡ caa05d4a-df20-11eb-111e-ddf5ea2bf2a8
[1., 2.], [1. 2.]

# ╔═╡ ca8a4078-df20-11eb-1ca3-df72191dd416
function distance(x, y, a, b, c)
  return abs(a*x + b*x - c) / √(a^2 + b^2 + epsilon)
end

# ╔═╡ ca704fb0-df20-11eb-2b58-29d929071fd8


# ╔═╡ Cell order:
# ╟─4d813b8c-dd9e-11eb-1131-7d43433427ed
# ╠═32ec40ec-df19-11eb-3b93-831604ef09c6
# ╟─0c155fae-df27-11eb-141f-b1643d8eedd1
# ╟─ec857128-df1d-11eb-0385-85e189ae94ab
# ╟─8e8bb7fa-df20-11eb-3b6b-7953e25fa4ae
# ╟─a5d5b1e4-df17-11eb-3894-493f14794266
# ╟─2a8af174-df27-11eb-1f6e-1592ce0e8452
# ╟─cde3dc82-df27-11eb-23a1-4110a17de198
# ╟─e046a8aa-df22-11eb-0305-4b844ab449d0
# ╟─98155677-1c37-4a4c-ae51-704c9bab9083
# ╠═cb035256-df20-11eb-2734-1fabc3195fd5
# ╠═cae22a2c-df20-11eb-3ff1-bb7e88c9c96f
# ╠═cabb3598-df20-11eb-13cd-c18f5447e8f2
# ╠═caa05d4a-df20-11eb-111e-ddf5ea2bf2a8
# ╠═ca8a4078-df20-11eb-1ca3-df72191dd416
# ╠═ca704fb0-df20-11eb-2b58-29d929071fd8
