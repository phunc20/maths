<b>Def.</b> A square matrix is said to be <b>separable</b> if all its rows are linear multiples of one of its row. For example, the following Gaussian blur kernel is separable.

$$
\frac{1}{256}
\begin{bmatrix}
    1 &  4 &  6 &  4 & 1 \\
    4 & 16 & 24 & 16 & 4 \\
    6 & 24 & 36 & 24 & 6 \\
    4 & 16 & 24 & 16 & 4 \\
    1 &  4 &  6 &  4 & 1 \\
\end{bmatrix}
=
\frac{1}{256}
\begin{bmatrix}
    1 \\  4 \\  6 \\  4 \\ 1 \\
\end{bmatrix}
\begin{bmatrix}
    1 &  4 &  6 &  4 & 1 \\
\end{bmatrix}
$$

A few more examples:
- $\begin{bmatrix} -1 & -2 & -1 \\ -2 & 16 & -2 \\ -1 & -2 & -1 \end{bmatrix}$ is <b>NOT</b> separable.<br><br>
- $\begin{bmatrix} -1 & -3 & -1 \\ 0 & 0 & 0 \\ 1 & 3 & -1\end{bmatrix}$ is separable.





