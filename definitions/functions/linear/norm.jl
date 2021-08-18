### A Pluto.jl notebook ###
# v0.15.1

using Markdown
using InteractiveUtils

# ╔═╡ 0c45e9aa-e0ba-11eb-0f56-af8192849f70
begin
  using Pkg
  Pkg.add("PlutoUI")
  using PlutoUI
end

# ╔═╡ e840f8ca-4ed6-4839-baeb-312cc457e5be
PlutoUI.TableOfContents(aside=true)

# ╔═╡ 293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
md"""
# Motivations
When we study undergraduate maths, in particular, linear algebra, the symbol ``\mathscr{L}(E, F)`` is sometimes employed to mean the space of all linear transformations from ``E`` to ``F``. But then, when we study a little bit higher, our books and professors start to use ``\mathscr{L}(E, F)`` to mean the space of all linear **_continuous_** transformations from ``E`` to ``F``. The topic we want to discuss here is
> Why sometimes there is continuity and somtimes not in the notation of ``\mathscr{L}(E, F)``?

Let's first read the following statement.
> To define a norm on the space ``%\mathscr{L}(E, F)`` of linear transformations btw two vector spaces
> ``E, F`` (both on ``\mathbb{R}`` or both on ``\mathbb{C}``), one way is
> to equipe the vector spaces ``E`` and ``F`` with norms and the linear transformations with continuity.
>
> In other words, the space of linear continuous transformations
> ``%\mathscr{L}(E, F)`` admits a norm.

We will understand why this is true later. For the moment being, I would like us to
think together about what drives us to define a norm for such entities as linear transformations.

According to what I have learned, one such motivation comes from calculus:$(HTML("<br>"))
When we study calculus, we all have to learn the second derivative.
Let us recall how the second derivative is introduced in an abstract setting.

Let ``E, F`` be two normed vector spaces (We need norms to be able to speak of
differentiability), and let ``f: U \subset E \to F`` be a function, where ``U`` is open in ``E\,.`` Then, by definition, ``f`` is differentiable at a point ``a \in U`` if there exists a linear transformation ``f'(a): E \to F`` s.t.
```math
\newcommand{\norm}[1]{\lVert{#1}\rVert}
f(a + h) = f(a) + f'(a)(h) + o(\norm{h})\,,
```
where the `` o(\norm{h})`` simply means
```math
\lim_{\norm{h}\to 0} \frac{\norm{f(a + h) - f(a) - f'(a)(h)}}{\norm{h}} = 0\,.
```

> **(?)** The derivative ``f'(a)``, does it **_suffice_** to be **_merely linear_**?
> Or it needs to be **_continuous_** as well?

Note that, if we are to further discuss whether ``f`` is twice differentiable at ``a``, we
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

Let ``T: E \to F`` be a linear transformation. Then
for all coefficient ``a`` and all vector ``x \in E``, we have
```math
\newcommand{\norm}[1]{\lVert{#1}\rVert}
\newcommand{\abs}[1]{\lvert{#1}\rvert}
\norm{T(ax)} = \abs{a}\;\norm{T(x)}\,,
```

In particular, if there exists some ``x_{0} \in E`` s.t. ``T(x_{0}) \ne 0``, then we see that
```math
\begin{align}
  \lim_{a \to \infty} \norm{aT(x_{0})} &= \infty\,, \\
  \lim_{a \to -\infty} \norm{aT(x_{0})} &= \infty\,, \\
  \lim_{a \to 0} \norm{aT(x_{0})} &= 0\,.
\end{align}
```

If no such ``x_{0}`` exists, then, uninterestingly, ``T = 0``, the zero function.

Coined in English, the above just tells us that
> In every direction ``x`` in which ``T`` does not zero out, the norm ``\norm{T(ax)}`` tends to ``\infty`` as it goes to the extremities.

So one idea could be to consider a representative for each and every direction, and then try to produce a norm from these representatives, like a progressive election:

- either ``\norm{T} := \sup_{\norm{x}=1} \norm{T(x)}``
- or ``\quad\;\,\norm{T} := \inf_{\norm{x}=1} \,\norm{T(x)}``

The definition via ``\inf``  has some drawbacks. For example,

- if ``\norm{T(x_{0})} = 0`` for some ``x_{0} \ne 0`` then ``\norm{T(\frac{1}{\norm{x_{0}}} x_{0})} = \frac{1}{\norm{x_{0}}} \norm{T(x_{0})} = 0\,.``
  - Since, ``\frac{1}{\norm{x_{0}}} x_{0}`` is a unit vector, this implies that
    ``\inf_{\norm{x}=1} \norm{T(x)} = 0\,.``
  - Had the ``\inf`` definition been a valid norm, we would have
    ``\norm{T} = 0``, which implies ``T = 0``, the zero function.
    This is the drawback I mentioned: when ``T`` zeros out in some direction,
    ``T`` has to zero out in all directions in order for the ``\inf`` definition
    to become a valid norm. This requires too much. Let alone saying
    requiring so much has not readily made the ``\inf`` definition a real norm.
    It was just a necessary condition.

Let's see if ``\inf``'s counterpart, the ``\sup`` definition, can make it until the end. And then we will come back to see if it is still possible to have a norm defined via ``\inf\,.``
"""

# ╔═╡ 6e593c67-1d05-41ae-bee6-6b63605b28ef
md"""
## ``\norm{T} := \sup_{\norm{x}=1} \norm{T(x)}``
First of all, to be able to define like this, we must require that the set
```math
\left\{\,\norm{T(x)} \,\middle\vert\; \norm{x}=1\,\right\}
```
be bounded. This is not automatic. Indeed, as we shall see, there exist linear functions that do not satisfy this.

We show that the norm ``\norm{\cdot}`` defined on the set

```math
V := \left\{T \,\middle|\; T: E \to F \;\text{linear} \quad\text{and}\quad \sup_{\norm{x}=1} \norm{T(x)} < \infty  \right\}
```
is a norm.

We'd better first show that ``V`` is a vector space. Since the demonstration should be quite straightforward, we only pick a few points to prove.

- ``T, S \in V \implies T + S \in V``
  - ```math
    \sup_{\norm{x}=1} \norm{(T+S)(x)} \le \sup_{\norm{x}=1} \left(\norm{T(x)} +
    \norm{S(x)}\right)
    \le \sup_{\norm{x}=1} \norm{T(x)} + \sup_{\norm{x}=1} \norm{S(x)}
    ```
- ``a \;\text{coefficient}, T \in S \implies aT \in S``
  - ```math
    \sup_{\norm{x}=1} \norm{(aT)(x)} = \sup_{\norm{x}=1} \abs{a}\norm{T(x)}
    = \abs{a}\sup_{\norm{x}=1} \norm{T(x)}
    ```
  - Note that the above is stronger than an inequality. We prove it stronger because later on we can take this result to establish one condition that a norm must satisfy.

It is also quite straightforward to prove that ``\norm{\cdot}`` is a norm on ``V``.

- ``\norm{T} \ge 0 \quad\forall\; T \in V``
- ``\norm{T} = 0 \iff T = 0``
- ``\norm{aT} = \abs{a} \norm{T} \quad\forall\; a, T``
- ``\norm{T+S} \le \norm{T} + \norm{S} \quad\forall\; T, S \in V``

In conclusion,
> we've found a norm defined on ``V``, a subspace of the space of all linear functions from ``E`` to ``F``.

Great! $(HTML("<br>"))
Remember our example on derivatives? If we ask the derivative ``f'(a)`` to lie in ``V``, then there is a norm on every element of ``V`` and it is valid for us
to discuss ``f''``.

> But what does this have to do with continuity?

It turns out that the demand
```math
\sup_{\norm{x}=1} \norm{T(x)} < \infty
```
coupled with the fact that ``T`` is linear constitutes continuity.

Indeed, assuming that ``T`` is linear, then it is well-known that
```math
\sup_{\norm{x}=1} \norm{T(x)} < \infty \iff
T \;\text{continuous at}\; 0 \iff
T \;\text{continuous on}\; E\,.
```

Those who don't believe may benefit from proving these implications by themselves.

Note that, in general, ``V`` is a proper subset of the set of all linear functions from ``E`` to ``F``. That is to say, there exist discontinuous linear transformations. Cf. [Appendix B](## B. Examples of Discontinuous Linear Transformations)
"""

# ╔═╡ 5fa9dfdf-7ae3-42ac-a02c-b89afbdcad28
md"""
## ``\norm{T} := \inf_{\norm{x}=1} \norm{T(x)}``
Unlike for ``\sup``, since any norm is always bounded below by ``0``, ``\inf_{\norm{x}=1} \norm{T(x)}`` always exist for all ``T: E \to F``.
So here we don't have to restrict to a subset ``V`` of the set of all linear
transformations from ``E`` to ``F``.

In general, this ``\inf`` definition does not give us a norm,
as the following example shows. Consider
``E = F = \mathbb{R}^{2}`` and the two linear functions ``T, S: E \to F``
```math
\begin{align}
  T: e_{1} \mapsto e_{1},\; e_{2} \mapsto 0 \\
  S: e_{2} \mapsto e_{2},\; e_{1} \mapsto 0 \\
\end{align}
```
where ``\{e_{1}, e_{2}\}`` denotes the canonical basis for ``\mathbb{R}^{2}``.

Then ``T+S = I``, the identity function ``\mathbb{R}^{2} \to \mathbb{R}^{2}``. Indeed,
for all ``x \in \mathbb{R}^{2}``, we see that
```math
\begin{align}
(T+S)(x) &= (T+S)(x_{1}e_{1} + x_{2}e_{2}) \\
         &= T(x_{1}e_{1} + x_{2}e_{2}) + S(x_{1}e_{1} + x_{2}e_{2}) \\
         &= x_{1}e_{1} + x_{2}e_{2} \\
         &= x\,.
\end{align}
```

As a consequence,
```math
\inf_{\norm{x}=1} \norm{(T+S)(x)} = 1 > 0 + 0 =
\inf_{\norm{x}=1} \norm{T(x)} + \inf_{\norm{x}=1} \norm{S(x)},
```
which says that the triangular inequality simply cannot be satisfied.
"""

# ╔═╡ 1e673c5f-bd3d-4e5b-a094-e0dbee6c4f8d
md"""
## A Comment on Linear Algebra
This comment is targeted at a small portion of readers of the current article, including myself 10 years ago. More specifically, it is targeted at some undergraduates like I was a decade ago.

When we enter into college, mathematics major, the first year undergraduate mathematics conventionally teach us calculus and linear algebra.
Then we go on to study ODE, PDE, differential geometry, complex analysis, and so on, and so forth. But when asked, "what good is linear algebra?", a portion among us will not be able to give an interesting answer at the age of a college student.

One viewpoint that this article tries to convey is that
> Actually, linearity is the simplest and almost always the first thing that
> we could think of to do. Although there is _algebra_ in the name of
> _linear algebra_, linear algebra is not constrained to be used in algebra.
> Even in calculus, which is classified as an _analysis_ course,
> such fundamental entities as the derivatives are linearities, like we just saw.
>
> Linear algebra is used in a lot of places, both in various math branches
> and in practical engineering.
>
> We simplify things and we study linear algebra so that
> we know (at least) how to cope with simplified, linear things.
"""

# ╔═╡ 04895de2-1f06-4a55-9989-9fa26505a744
md"""
# References
The materials presented here are generally considered quite elementary and could probably be found in many books and on the Internet. In particular, the author first read these in the following book

- [Cours de calcul différentiel, Henri Cartan](https://www.amazon.com/Cours-calcul-diff%C3%A9rentiel-Henri-Cartan/dp/2705667024)
"""

# ╔═╡ 83ed0c76-b9cc-4a9d-8583-dd82f7447775
md"""
# Appendices
At first I thought I was going to write sth in these appendices. It turned out that

01. I am running out of time before the submission deadline of [`some1`](https://www.3blue1brown.com/blog/some1)
02. There are, unsurprisingly, excellent resources online on the topics that these appendices try to cover, and I am not confident that my own writing will render the ideas clearer than they do.

As a consequence, I will temporarily refer the interested readers to these resources.


## A. Continuity Is Automatic when ``\dim(E)`` Is Finite
That is,
> If ``T: E \to F`` is linear and ``\dim(E)`` is finite, then, ``T`` is a continuous function.

**Proof.** $(HTML("<br>"))
Let ``\{e_{1}, e_{2}, \ldots, e_{n}\}`` be a basis for ``E``. Then for all ``x \in E`` with ``\norm{x}_{E} = 1``, we have
```math
  \norm{T(x)}_{F} =
  %\norm{T(\sum_{i=1}^{n} x_{i}e_{i})}_{F} =
  \norm{\sum_{i=1}^{n} x_{i}T(e_{i})}_{F} \le
  \sum_{i=1}^{n} \abs{x_{i}}\, \norm{T(e_{i})}_{F} \le
  \left(\max_{i=1,2,\ldots, n} \norm{T(e_{i})}_{F}\right) \sum_{i=1}^{n} \abs{x_{i}}
```
It can be shown that the mapping ``x \mapsto \sum_{i=1}^{n} \abs{x_{i}}`` defines a norm on ``E``. Additionally, we know that all norms on a finite-dimensional vector space are **_equivalent_**, whence, continuing the foregoing inequality gives us
```math
  \norm{T(x)}_{F} \le
  M \sum_{i=1}^{n} \abs{x_{i}} \le
  M C \norm{x}_{E} =
  M C
```
for some constant ``C > 0``. (We have denoted ``M = \max_{i=1,2,\ldots, n} \norm{T(e_{i})}_{F}`` and used the fact that ``\norm{x}_{E} = 1``.)

This completes the proof that ``T`` is continuous.


## B. Examples of Discontinuous Linear Transformations
- This Wikipedea entry consists of much more than a mere example: <https://en.wikipedia.org/wiki/Discontinuous_linear_map>
"""

# ╔═╡ Cell order:
# ╟─0c45e9aa-e0ba-11eb-0f56-af8192849f70
# ╟─e840f8ca-4ed6-4839-baeb-312cc457e5be
# ╟─293031b4-e0bb-11eb-1f5b-9da7ddf56b6c
# ╟─b65e4364-e0cf-11eb-0d0e-2f5418a1286a
# ╟─6e593c67-1d05-41ae-bee6-6b63605b28ef
# ╟─5fa9dfdf-7ae3-42ac-a02c-b89afbdcad28
# ╟─1e673c5f-bd3d-4e5b-a094-e0dbee6c4f8d
# ╟─04895de2-1f06-4a55-9989-9fa26505a744
# ╟─83ed0c76-b9cc-4a9d-8583-dd82f7447775
