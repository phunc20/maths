### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 0c45e9aa-e0ba-11eb-0f56-af8192849f70
begin
  using Pkg
  Pkg.add([
    "PlutoUI",
    "Plots",
    "PlotlyJS",
    "WebIO",
  ])
  using PlutoUI
  using Plots
  #plotly()
  gr()
  using PlotlyJS
  using WebIO
end

# ╔═╡ 87226ee7-7adc-4fab-a86a-c242a85f14d2
let
  u = [1. 0.]'
  x = reshape(range(-1, 1; length=11), 1, :)
  u * x
end

# ╔═╡ 86e93269-6f70-4ebb-8390-74c4f8111cce
let
  u = [1. 0.]'
  v = [0. 1.]'
  Tu = [3. 4.]'
  Tv = [-1. 0.]'
  n_pts = 100
  #x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  x = range(-1, 1; length=n_pts÷2)
  y = .√(1 .- x.^2)
  y = [y; -y[2:end-1]]
  x = [x; x[2:end-1]]
  Plots.scatter(x, y,
    aspect_ratio=:equal,
    background_color=:black
  )
end

# ╔═╡ c7f38ef0-263a-45a7-b9ac-8b9c165419b2
function T(coeff, basis)
  return basis * coeff
end

# ╔═╡ ade94a6d-a68d-4c82-9dba-89fd70fd025e
let
  coeff = [1 0 -1  0
           0 1  0 -1]
  Tu = [3. 4.]'
  Tv = [-1. 0.]'
  basis = [Tu Tv]
  T(coeff, basis)
end

# ╔═╡ 7e348501-80aa-43a0-8b82-4cd0d8081df1
let
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  size(y), size(-y[2:end-1]), size(-y[1:end, 2:end-1])
end

# ╔═╡ 814749da-b5de-4247-9eba-58b2055dd4fd
let
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  hcat(y, -y[1:end, 2:end-1])
end

# ╔═╡ 6e4da27d-4861-4d3a-a3af-0c966685d698
md"""
The following recreates the same circle as above but with more flexibility.
"""

# ╔═╡ ac39c912-7480-461f-97d6-376ce1f01cc1
let
  u = [1. 0.]'
  v = [0. 1.]'
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  #x = [x, x[2:end-1]]
  coeff = vcat(
    hcat(x, x[1:end, 2:end-1]),
    hcat(y, -y[1:end, 2:end-1]),
  )
  pts = [u v] * coeff
  Plots.scatter(
    pts[1, 1:end],
    pts[2, 1:end],
    aspect_ratio=:equal,
    background_color=:black
  )
end

# ╔═╡ f943106b-1d37-4240-95f4-087b958d62e3
let
  Tu = [3. 4.]'
  Tv = [-1. 0.]'
  basis = [Tu Tv]
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  coeff = vcat(
    hcat(x, x[1:end, 2:end-1]),
    hcat(y, -y[1:end, 2:end-1]),
  )
  pts = T(coeff, basis)
  Plots.scatter(
    pts[1, 1:end],
    pts[2, 1:end],
    aspect_ratio=:equal,
    background_color=:black
  )
end

# ╔═╡ 56348137-1190-4a96-9c2b-260b5c5b574a
size([1 2 3; 4 5 6], 2)

# ╔═╡ cb58d7fd-0aa1-4371-bcc1-89dd476e4cb1
[1 2 3; 4 5 6][1:end, [2]]

# ╔═╡ b8a8190b-2ffd-4ba0-866c-ed12477b672e
let
  Tu = [3. 4.]'
  Tv = [-1. 0.]'
  basis = [Tu Tv]
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  coeff = vcat(
    hcat(x, x[1:end, 2:end-1]),
    hcat(y, -y[1:end, 2:end-1]),
  )
  plt = Plots.plot(
    1,
    xlim = (-30, 30),
    ylim = (-30, 30),
    aspect_ratio=:equal,
    background_color=:black,
    title = "Image of unit sphere in 2D",
    marker = 2,
  )
  # build an animated gif by pushing new points to the plot, saving every 3 frame
  @gif for col = 1:size(coeff, 2)
    pt = T(coeff[1:end, [col]], basis)
    push!(plt, pt[1, 1], pt[2, 1])
  end every 2
end

# ╔═╡ ccdca454-c175-4f67-bd4a-8663e4bd9756
md"""
Quite neat now, but it would become better if we make the motion
- direction-consistent
- zoomed-in
- no label
"""

# ╔═╡ c0ecedae-c66e-46a3-989e-7fc9642577fc
let
  Tu = [3. 4.]'
  Tv = [-1. 0.]'
  basis = [Tu Tv]
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  coeff = vcat(
    hcat(x, x[1:end, end-1:-1:2]),
    hcat(y, -y[1:end, end-1:-1:2]),
  )
  plt = Plots.plot(
    1,
    xlim=(-7, 7),
    ylim=(-7, 7),
    aspect_ratio=:equal,
    background_color=:black,
    title="Image of unit sphere in 2D",
    marker=2,
    label=false,
  )
  # build an animated gif by pushing new points to the plot, saving every 3 frame
  @gif for col = 1:size(coeff, 2)
    pt = T(coeff[1:end, [col]], basis)
    push!(plt, pt[1, 1], pt[2, 1])
  end every 1
end

# ╔═╡ 2e27720a-1ea1-48ba-85fd-ba7c12355a9d
let
  Tu = [3. 4.]'
  Tv = [0. 0.]'
  basis = [Tu Tv]
  n_pts = 100
  x = reshape(range(-1, 1; length=n_pts÷2), 1, :)
  y = .√(1 .- x.^2)
  coeff = vcat(
    hcat(x, x[1:end, end-1:-1:2]),
    hcat(y, -y[1:end, end-1:-1:2]),
  )
  plt = Plots.plot(
    1,
    xlim=(-7, 7),
    ylim=(-7, 7),
    aspect_ratio=:equal,
    background_color=:black,
    title="Image of unit sphere in 2D",
    marker=2,
    label=false,
  )
  # build an animated gif by pushing new points to the plot, saving every 3 frame
  @gif for col = 1:size(coeff, 2)
    pt = T(coeff[1:end, [col]], basis)
    push!(plt, pt[1, 1], pt[2, 1])
  end every 1
end

# ╔═╡ ee76cf5b-ada9-416d-be94-5451eafce775
md"""
Let's try with 3D.

It's a little hard to do the GIF with 3D, but let's at least start with a scatter plot.
"""

# ╔═╡ 7d0d395b-8c9f-4bd6-bc2d-5ff9af0e326d
[x for x in rand(range(-1,1;length=1_000), (2, 100))]

# ╔═╡ f9729911-9fb6-499e-b1e3-4e60775a8f4f
let
  square_xy = rand(range(-1,1;length=1_000), (2, 100))
  circle_xy = [square_xy[1:end, col] for col in 1:size(square_xy, 2) if sum(square_xy[1:end, col].^2) <= 1]
  #size(circle_xy)
  #square_xy, [col for col in 1:size(square_xy, 2) if sum(square_xy[1:end, col].^2) <= 1]
  #square_xy, [sum(square_xy[1:end, col].^2) for col in 1:size(square_xy, 2)]
end

# ╔═╡ b73ed7bc-4d9c-4f83-813e-9cf76ec602a8
md"""
### Stupidity: Polar Coordinate
I was so stupid as to forget the useful **_polar coordinate_**. Let's re-code the above using polar coordinate! I believe it's going to be simpler.
"""

# ╔═╡ e7640a11-24c0-49e8-b31e-58e8b2cff272
float(rand(-10:10, (2,2)))

# ╔═╡ 07539502-d5ef-48a0-9f2f-ae740f0a6c01
let
  #ρ = 1
  n_angles = 100
  ϵ = 1e-9
  coeff = zeros((3, n_angles^2))
  counter = 1
  #for (i, ϕ) in enumerate(range(0, π-ϵ; length=n_angles)), (j, θ) in enumerate(range(0, 2π-ϵ; length=n_angles))
  for ϕ in range(0, π-ϵ; length=n_angles), θ in range(0, 2π-ϵ; length=n_angles)
    coeff[1:end, counter] = [sin(ϕ)*cos(θ), sin(ϕ)*sin(θ), cos(ϕ)]
    counter += 1
  end
  basis = float(rand(-10:10, (3,3)))
  pts = T(coeff, basis)
  Plots.scatter(
    pts[1, 1:end],
    pts[2, 1:end],
    pts[3, 1:end],
    aspect_ratio=:equal,
    background_color=:black,
    label=false,
  )
end

# ╔═╡ f7b1407b-3c9a-4a66-ae2c-259fc6a2e1aa
md"""
Plotting like this is not very helpful.

This link <https://plotly.com/julia/3d-scatter-plots/> provides better scatter plots.

> It seems that extra effort is needed in order to use `PlotlyJS`, so I disabled it.
"""

# ╔═╡ a31dff2c-766c-4d52-8fb3-f9d058f310c3
PlotlyJS.plot, PlotlyJS.scatter

# ╔═╡ 0cedae98-fe16-47c9-a735-7c86af0c803a
let
  #ρ = 1
  n_angles = 100
  ϵ = 1e-9
  coeff = zeros((3, n_angles^2))
  counter = 1
  #for (i, ϕ) in enumerate(range(0, π-ϵ; length=n_angles)), (j, θ) in enumerate(range(0, 2π-ϵ; length=n_angles))
  for ϕ in range(0, π-ϵ; length=n_angles), θ in range(0, 2π-ϵ; length=n_angles)
    coeff[1:end, counter] = [sin(ϕ)*cos(θ), sin(ϕ)*sin(θ), cos(ϕ)]
    counter += 1
  end
  basis = float(rand(-10:10, (3,3)))
  pts = T(coeff, basis)
  #plotlyjs()
  PlotlyJS.Plot(PlotlyJS.scatter3d(
    x=pts[1, 1:end],
    y=pts[2, 1:end],
    z=pts[3, 1:end],
    height=400,
    #width=900,
  ))
end

# ╔═╡ 259744e6-4b87-43fb-ae9e-88e02c2c0f35
md"""
`PlotlyJS`'s 3D plot in this case is too small. Let's plot using `@gif` again.
"""

# ╔═╡ 03774574-6ebe-4146-875d-f654a88457c9
let
  #ρ = 1
  n_angles = 50
  ϵ = 1e-9
  coeff = zeros((3, n_angles^2))
  counter = 1
  #for (i, ϕ) in enumerate(range(0, π-ϵ; length=n_angles)), (j, θ) in enumerate(range(0, 2π-ϵ; length=n_angles))
  for ϕ in range(0, π-ϵ; length=n_angles), θ in range(0, 2π-ϵ; length=n_angles)
    coeff[1:end, counter] = [sin(ϕ)*cos(θ), sin(ϕ)*sin(θ), cos(ϕ)]
    counter += 1
  end
  basis = float(rand(-10:10, (3,3)))
  pts = T(coeff, basis)
  sct = Plots.plot3d(
    1,
    xlim=(-15, 15),
    ylim=(-20, 20),
    zlim=(-7, 7),
    aspect_ratio=:equal,
    background_color=:black,
    label=false,
  )
  @gif for col in 1:size(pts, 2)
    push!(sct, pts[1, col], pts[2, col], pts[3, col])
  end every 3
end

# ╔═╡ 6c790f78-464d-49c2-9621-d3677cd70d9e
let
  Tu = [3. 4.]'
  Tv = [1. 0.]'
  basis = [Tu Tv]
  n_angles = 100
  ϵ = 1e-9
  θ = range(0, 2π-ϵ; length=n_angles)
  coeff = zeros((2, n_angles))
  for (col, θ) in enumerate(range(0, 2π-ϵ; length=n_angles))
    coeff[1:end, col] = [cos(θ), sin(θ)]
  end
  pts = T(coeff, basis)
  plt = Plots.scatter(
    1,
    xlim=(-7, 7),
    ylim=(-7, 7),
    aspect_ratio=:equal,
    background_color=:black,
    title="Image of unit sphere in 2D",
    marker=2,
    label=false,
  )
  @gif for col = 1:size(coeff, 2)
    pt = pts[1:end, col]
    push!(plt, pt[1], pt[2])
  end every 1
end

# ╔═╡ Cell order:
# ╠═0c45e9aa-e0ba-11eb-0f56-af8192849f70
# ╠═87226ee7-7adc-4fab-a86a-c242a85f14d2
# ╠═86e93269-6f70-4ebb-8390-74c4f8111cce
# ╠═c7f38ef0-263a-45a7-b9ac-8b9c165419b2
# ╠═ade94a6d-a68d-4c82-9dba-89fd70fd025e
# ╠═7e348501-80aa-43a0-8b82-4cd0d8081df1
# ╠═814749da-b5de-4247-9eba-58b2055dd4fd
# ╟─6e4da27d-4861-4d3a-a3af-0c966685d698
# ╠═ac39c912-7480-461f-97d6-376ce1f01cc1
# ╠═f943106b-1d37-4240-95f4-087b958d62e3
# ╠═56348137-1190-4a96-9c2b-260b5c5b574a
# ╠═cb58d7fd-0aa1-4371-bcc1-89dd476e4cb1
# ╠═b8a8190b-2ffd-4ba0-866c-ed12477b672e
# ╟─ccdca454-c175-4f67-bd4a-8663e4bd9756
# ╠═c0ecedae-c66e-46a3-989e-7fc9642577fc
# ╠═2e27720a-1ea1-48ba-85fd-ba7c12355a9d
# ╟─ee76cf5b-ada9-416d-be94-5451eafce775
# ╠═7d0d395b-8c9f-4bd6-bc2d-5ff9af0e326d
# ╠═f9729911-9fb6-499e-b1e3-4e60775a8f4f
# ╟─b73ed7bc-4d9c-4f83-813e-9cf76ec602a8
# ╠═e7640a11-24c0-49e8-b31e-58e8b2cff272
# ╠═07539502-d5ef-48a0-9f2f-ae740f0a6c01
# ╟─f7b1407b-3c9a-4a66-ae2c-259fc6a2e1aa
# ╠═a31dff2c-766c-4d52-8fb3-f9d058f310c3
# ╠═0cedae98-fe16-47c9-a735-7c86af0c803a
# ╟─259744e6-4b87-43fb-ae9e-88e02c2c0f35
# ╠═03774574-6ebe-4146-875d-f654a88457c9
# ╠═6c790f78-464d-49c2-9621-d3677cd70d9e
