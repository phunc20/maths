### A Pluto.jl notebook ###
# v0.12.21

using Markdown
using InteractiveUtils

# ╔═╡ 0c45e9aa-e0ba-11eb-0f56-af8192849f70
begin
  using Pkg
  # .julia_env/ is in the root dir of this repo
  Pkg.activate("../../../.julia_env/oft")
  Pkg.add("PlutoUI")
  using PlutoUI
  using Plots
  #using TikzPictures
end

# ╔═╡ 293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
md"""
## Motivations
> To define a norm on a space ``%\mathscr{L}(E, F)`` of linear functions btw two vector spaces
> ``E, F``, one way is
> to equipe the vector spaces with norms and the functions with continuity.
>
> In other words, the space of linear continuous functions ``\mathscr{L}(E, F)``
> admits a norm.

We will come back to this statement later. For the moment being, I would like us to
think together about what drives us to define a norm on for such entities as linear functions.

According to what I have learned, the motivation might come from the
following:$(HTML("<br>")) 
When we study calculus, we all have to learn the second derivative.
Let us recall how the second derivative is introduced in an abstract setting.

Let ``E, F`` be two normed vector spaces (We need norms to be able to speak of
differentiability), and let ``f: U \subset E \to F`` be a function, where ``U`` is open in ``E\,.`` Then, by definition, ``f`` is differentiable at a point ``a \in U`` if there exists a linear function ``f'(a): E \to F`` s.t.
```math
\newcommand{\norm}[1]{\lVert{#1}\rVert}
f(a + h) = f(a) + f'(a)(h) + o(\norm{h})\,.
```
> **(?)** The derivative ``f'(a)``, does it **_suffice_** for it to be **_merely linear_**?
> Or it needs to be **_continuous_** as well?

Note that, if we are to discuss whether ``f`` is twice differentiable at ``a``, we
need

- ``f'`` is defined on an open set containing ``a`` denoted ``N_{a}\,.``
  - So ``f': N_{a} \to G``, where ``G`` denotes the space of linear functions from ``E`` to ``F\,.``
- We **_need_** ``G`` **_to have a norm_** in order to discuss the differentiability of ``f'\,.``

So, we see the necessity now. We need to consider the space of linear continuous functions ``\mathscr{L}(E, F)\,.``

"""

# ╔═╡ Cell order:
# ╟─0c45e9aa-e0ba-11eb-0f56-af8192849f70
# ╟─293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
