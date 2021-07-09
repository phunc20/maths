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
  #using Plots
  #using TikzPictures
end

# ╔═╡ 293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
md"""
# Motivations
> To define a norm on a space ``%\mathscr{L}(E, F)`` of linear functions btw two vector spaces
> ``E, F`` on ``\mathbb{R}`` or on ``\mathbb{C}``, one way is
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

So, we see the necessity now. We need a norm for linear functions.
"""

# ╔═╡ b65e4364-e0cf-11eb-0d0e-2f5418a1286a
md"""
## A Norm on Linear Functions
How do we define a norm on linear functions ``E \to F\,``? I think we can find
one by trial and error.

Defining ``\;\norm{f} := \sup_{x \in E} \norm{f(x)} = \infty\;`` or
``\;\norm{f} := \inf_{x \in E} \norm{f(x)} = -\infty\;`` are both of little interest.
Note that the equality to ``\infty`` or to ``-\infty`` are due to the linearity of ``f``:
```math
\newcommand{\abs}[1]{\lvert{#1}\rvert}
\norm{f(ax)} = \abs{a}\;\norm{f(x)}\,.
```

This drives us to another plausible definition: If the linearity renders impossible
defining the norm  as ``\sup`` or ``\inf`` of all the image vectors, why don't we
just take one representative for each possible direction and then take the ``\sup`` or
the ``\inf``. That is,

- either ``\norm{f} := \sup_{\norm{x}=1} \norm{f(x)}``
- or ``\quad\;\,\norm{f} := \inf_{\norm{x}=1} \norm{f(x)}``

The definition via ``\inf``  has some drawbacks in certain situations. For example,

- if ``\norm{f(x_{0})} = 0`` for some ``x_{0} \ne 0`` then ``\norm{f(\frac{1}{\norm{x_{0}}} x_{0})} = \frac{1}{\norm{x_{0}}} \norm{f(x_{0})} = 0\,.``
  - Since, ``\frac{1}{\norm{x_{0}}} x_{0}`` is a unit vector, this implies that
    ``\inf_{\norm{x}=1} \norm{f(x)} = 0\,.``
  - But ``f`` can be different from the zero function.
    (``f`` only zeros out in the direction of ``x_{0}\,.``)
    Had we defined ``\inf`` as ``f``'s norm, we would have ``\norm{f} = 0`` for
    a non-zero ``f``, a contradiction to the definition of norm.
    (Only the zero vector can have zero norm.)

Let's see if ``\inf``'s counterpart, the ``\sup`` definition, can make it until the end. And then we will come back to see if it is still possible to have a norm defined via ``\inf\,.``
"""

# ╔═╡ Cell order:
# ╠═0c45e9aa-e0ba-11eb-0f56-af8192849f70
# ╠═293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
# ╠═b65e4364-e0cf-11eb-0d0e-2f5418a1286a
