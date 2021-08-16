### A Pluto.jl notebook ###
# v0.15.1

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

# ╔═╡ e840f8ca-4ed6-4839-baeb-312cc457e5be
PlutoUI.TableOfContents(aside=true)

# ╔═╡ 293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
md"""
# Motivations
When we study undergraduate maths, in particular, linear algebra, the symbol ``\mathscr{L}(E, F)`` is sometimes employed to mean the space of all linear transformations from ``E`` to ``F``, where most of the time in our undergraduate education, ``\dim(E)`` is finite. But then, when we study a little bit higher, our books and professors start to use ``\mathscr{L}(E, F)`` to mean the space of all linear **_continuous_** transformations from ``E`` to ``F``. The topic we want to discuss here is
> Why sometimes there is continuity and somtimes not in the notation of ``\mathscr{L}(E, F)``?

Let's first read the following statement.
> To define a norm on the space ``%\mathscr{L}(E, F)`` of linear transformations btw two vector spaces
> ``E, F`` (both on ``\mathbb{R}`` or both on ``\mathbb{C}``), one way is
> to equipe the vector spaces ``E`` and ``F`` with norms and the linear transformations with continuity.
>
> In other words, the space of linear continuous transformations
> ``%\mathscr{L}(E, F)`` admits a norm.

We will come back to this statement later. For the moment being, I would like us to
think together about what drives us to define a norm for such entities as linear transformations.

According to what I have learned, one such motivation comes from calculus:$(HTML("<br>"))
When we study calculus, we all have to learn the second derivative.
Let us recall how the second derivative is introduced in an abstract setting.

Let ``E, F`` be two normed vector spaces (We need norms to be able to speak of
differentiability), and let ``f: U \subset E \to F`` be a function, where ``U`` is open in ``E\,.`` Then, by definition, ``f`` is differentiable at a point ``a \in U`` if there exists a linear transformation ``f'(a): E \to F`` s.t.
```math
\newcommand{\norm}[1]{\lVert{#1}\rVert}
f(a + h) = f(a) + f'(a)(h) + o(\norm{h})\,.
```
> **(?)** The derivative ``f'(a)``, does it **_suffice_** to be **_merely linear_**?
> Or it needs to be **_continuous_** as well?

Note that, if we are to discuss whether ``f`` is twice differentiable at ``a``, we
need that

- ``f'`` be defined on an open set containing ``a`` denoted ``N_{a}\,``.
  - ``f': N_{a} \to G``, where ``G`` denotes the space of linear transformations from ``E`` to ``F``.
- ``G`` **_have a norm_** in order to discuss the differentiability of ``f'``.

So, we see one necessity -- We need a norm for linear transfomrations from ``E`` to ``F``.
"""

# ╔═╡ b65e4364-e0cf-11eb-0d0e-2f5418a1286a
md"""
# A Norm on Linear Transformations
How do we define a norm on linear transformations ``E \to F\,``? I guess we can find
one by trial and error.


For all coefficient ``a`` and all vector ``x \in E``, we have
```math
\newcommand{\norm}[1]{\lVert{#1}\rVert}
\newcommand{\abs}[1]{\lvert{#1}\rvert}
\norm{f(ax)} = \abs{a}\;\norm{f(x)}\,,
```

In particular, if there exists some ``x_{0} \in E`` s.t. ``f(x_{0}) \ne 0``, then we see that
```math
\begin{align}
  \lim_{a \to \infty} \norm{af(x_{0})} &= \infty\,, \\
  \lim_{a \to -\infty} \norm{af(x_{0})} &= \infty\,, \\
  \lim_{a \to 0} \norm{af(x_{0})} &= 0\,.
\end{align}
```

If no such ``x_{0}`` exists, then, uninterestingly, ``f \equiv 0``.

Coined in English, the above just tells us that
> In every direction ``ax``, the norm ``\norm{f(ax)}`` tends to ``\infty`` as it goes to the extremities.

So one idea could be to consider a representative for each and every direction, and then try to produce a norm from these representatives, like a progressive election:

- either ``\norm{f} := \sup_{\norm{x}=1} \norm{f(x)}``
- or ``\quad\;\,\norm{f} := \inf_{\norm{x}=1} \,\norm{f(x)}``

The definition via ``\inf``  has some drawbacks in certain situations. For example,

- if ``\norm{f(x_{0})} = 0`` for some ``x_{0} \ne 0`` then ``\norm{f(\frac{1}{\norm{x_{0}}} x_{0})} = \frac{1}{\norm{x_{0}}} \norm{f(x_{0})} = 0\,.``
  - Since, ``\frac{1}{\norm{x_{0}}} x_{0}`` is a unit vector, this implies that
    ``\inf_{\norm{x}=1} \norm{f(x)} = 0\,.``
  - Had the ``\inf`` definition been a valid norm, we would have
    ``\norm{f} = 0``, which implies ``f = 0``, the zero function.
    This is the drawback I was saying, when ``f`` zeros out in some direction,
    ``f`` has to zero out in all directions in order for the ``\inf`` definition
    to become a valid norm. This does not seem realistic. Let alone saying
    requiring so much has not readily made the ``\inf`` definition a real norm.
    It was just a necessary condition.

Let's see if ``\inf``'s counterpart, the ``\sup`` definition, can make it until the end. And then we will come back to see if it is still possible to have a norm defined via ``\inf\,.``
"""

# ╔═╡ 6e593c67-1d05-41ae-bee6-6b63605b28ef
md"""
## ``\norm{f} := \sup_{\norm{x}=1} \norm{f(x)}``
First of all, to be able to define like this, we must require that the set
```math
\left\{\,\norm{f(x)} \,\middle\vert\; \norm{x}=1\,\right\}
```
be bounded. This is not automatic. Indeed, as we shall see, there exist linear functions that do not satisfy this.

We show that the norm ``\norm{\cdot}`` defined on the set

```math
S := \left\{f \,\middle|\; f: E \to F \;\text{linear} \quad\text{and}\quad \sup_{\norm{x}=1} \norm{f(x)} \;\text{exists}  \right\}
```
is a norm.

We'd better first show that ``S`` is a vector space. Since the demonstration should be quite straightforward, we only pick a few points to prove.

- ``f, g \in S \implies f + g \in S``
  - ```math
    \sup_{\norm{x}=1} \norm{(f+g)(x)} \le \sup_{\norm{x}=1} \left(\norm{f(x)} +
    \norm{g(x)}\right)
    \le \sup_{\norm{x}=1} \norm{f(x)} + \sup_{\norm{x}=1} \norm{g(x)}
    ```
- ``a \;\text{coefficient}, f \in S \implies af \in S``
  - ```math
    \sup_{\norm{x}=1} \norm{(af)(x)} = \sup_{\norm{x}=1} \abs{a}\norm{f(x)}
    = \abs{a}\sup_{\norm{x}=1} \norm{f(x)}
    ```
  - Note that the above is stronger than an inequality. We prove it stronger because later on we can take this same proof to prove one condition that a norm must satisty.

It is also quite straightforward to prove that ``\norm{\cdot}`` is a norm on ``S``.

- ``\norm{f} \ge 0 \quad\forall\; f \in S``
- ``\norm{f} = 0 \iff f = 0``
- ``\norm{af} = \abs{a} \norm{f} \quad\forall\; a, f``
- ``\norm{f+g} \le \norm{f} + \norm{g} \quad\forall\; f,g \in S``

"""

# ╔═╡ 83ed0c76-b9cc-4a9d-8583-dd82f7447775
md"""
# Appendices
## A. Continuity Is Automatic when ``\dim(E)`` Is Finite
## B. Examples of Discontinuous Linear Transformations
"""

# ╔═╡ ca68eaab-bf46-4bf4-bf28-9d170d5370c9


# ╔═╡ Cell order:
# ╠═0c45e9aa-e0ba-11eb-0f56-af8192849f70
# ╟─e840f8ca-4ed6-4839-baeb-312cc457e5be
# ╠═293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
# ╠═b65e4364-e0cf-11eb-0d0e-2f5418a1286a
# ╟─6e593c67-1d05-41ae-bee6-6b63605b28ef
# ╟─83ed0c76-b9cc-4a9d-8583-dd82f7447775
# ╠═ca68eaab-bf46-4bf4-bf28-9d170d5370c9
