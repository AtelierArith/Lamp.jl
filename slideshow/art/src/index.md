---
marp: true
theme: ./custom
paginate: true
class: invert
katex: true
---

# Happy $\infty$

AtelierArith `@terasakisatoshi`

---

# このスライドについて

https://atelierarith.github.io/Lamp.jl/

![](qr_thispage.png)

---

- みなさんから事前に数字をいただきました
- その数字をタネ (seed, 🌾) にして模様を作りました
- そのタネから`反復関数系`というものを用いて図形を作りました
- それが皆様に配布したものです

---

## 反復関数系(突然ですが)

$x_0 = 0, y_0 = 0$ とする.

- Step 1:  色んな $w_{11}, w_{12}, w_{21}, w_{22}$, $b_1, b_2$ を用意する
	- ここで皆さんのタネを使ってます
- Step 2: $x_n$, $y_n$ を用いて下記の式を計算する

$$
\begin{align}
x_{n+1} &= w_{11} x_n + w_{12} y_n + b_1 \\
y_{n+1} &= w_{21} x_n + w_{22} y_n + b_2
\end{align}
$$

$x_{n+1}, y_{n+1}$ を得る. Step 1 に戻り以下同じようなことを繰り返す


(漸化式ってのをもしかしたら昔習ったかもしれない？)

---

## 反復関数系(例えば)

$w_{11}=\frac{1}{2}, w_{12}=-\frac{1}{2}, w_{21}=\frac{1}{2}, w_{22}=\frac{1}{2}, b_1 = b_2= \frac{1}{2}$ 

$$
\begin{align}
x_{n+1} &= \frac{x_n - y_n}{2} + \frac{1}{2} \\
y_{n+1} &= \frac{x_n + y_n}{2} + \frac{1}{2}
\end{align}
$$

こんな感じの計算をいっぱいする

---

## 反復関数系(行列を知ってる方向け)

$$
\begin{aligned}
W = \begin{bmatrix}
	w_{11} & w_{12} \\
	w_{21} & w_{22}
\end{bmatrix}, \quad
\vec{b} = \begin{bmatrix}
	b_1 \\
	b_2
\end{bmatrix}, \quad
\vec{v}_n = \begin{bmatrix} x_{n} \\ y_{n} \end{bmatrix} 
\end{aligned}
$$

$$
\begin{aligned}
\vec{v}_{n+1}
&= f(\vec{v}_n) = W\ \vec{v}_n+ \vec{b} = \begin{bmatrix} w_{11} x_n + w_{12} y_n + b_1 \\ w_{21} x_n + w_{22} y_n + b_2 \end{bmatrix}
\end{aligned}
$$

これをひたすら計算する. 
漸化式ってのをもしかしたら習ったかもしれない

---

## え?! 計算しろって？

---

## え?! 計算しろって？

- ヤダヤダ！
- そうだプログラムを書こう

---

## Julia というプログラミング言語

(雰囲気さえわかれば良い)

```julia
x = 0.0; y = 0.0 # 初期値
struct Affine; W; b; end # Affine 変換
aff(x, y) = W * [x, y] + b
transforms::Vector{Affine} # 適当に決める
catdist = Distributions.Categorical(p)
pts = NTuple{2, Float64}[]
for _ in 1:niter
    # 指定の割合で Affine 変換をランダムに選ぶ
    aff = rand(catdist, transforms)
    x, y = aff(x, y); push!(pts, (x, y))
end
```

---

### [Barnsley fern](https://en.wikipedia.org/wiki/Barnsley_fern)

```julia
transforms = (
	Affine([0. 0.; 0 0.16], [0., 0.]),
	Affine([0.85 0.04; -0.04 0.85], [0., 1.6]),
	Affine([0.2 -0.26; 0.23 0.22], [0., 1.6]),
	Affine([-0.15 0.28; 0.26 0.24], [0., 0.44]),
)
catdist = Categorical([0.01,0.85,0.07,0.07])
(transforms, catdist)
```

[Pluto Notebook](https://atelierarith.github.io/julia_tutorial_pluto_materials/ifs_revised.html)


![bg right auto](https://user-images.githubusercontent.com/16760547/271758315-9d5fc54a-0cf5-496a-aa62-c56a074ee1ef.png)


---

### [Lévy C curve](https://en.wikipedia.org/wiki/L%C3%A9vy_C_curve)

```julia
transforms = (
	Affine([0.5 -0.5; 0.5 0.5], [0., 0.]),
	Affine([0.5 0.5; -0.5 0.5], [0.5, 0.5]),
)
catdist = Categorical([0.5, 0.5])
```

[Pluto Notebook](https://atelierarith.github.io/julia_tutorial_pluto_materials/ifs_revised.html)

![bg right auto](https://user-images.githubusercontent.com/16760547/271758165-9ea1a344-ed7b-4338-a6ec-d6e6c217813f.png)

---

# RandomLogos.jl

- [README](https://github.com/AtelierArith/RandomLogos.jl)
- [docs](https://atelierarith.github.io/RandomLogos.jl/dev)
- [Pluto Notebook](https://atelierarith.github.io/julia_tutorial_pluto_materials/random_logos.html)
![bg cover](https://user-images.githubusercontent.com/16760547/244692778-87a43f0e-512f-4791-8a22-fa49ce24d546.png)

---

# 体験場所

https://happy-infinity.atelier-arith.jp/

![](qr_demosite.png)

---

## タネ 🌾 について(seed=1008)

```julia
julia> using Random; 🌾=1008; rng = Xoshiro(🌾); rand(rng, ["オモテ", "ウラ"], 10)
10-element Vector{String}:
 "オモテ"
 "オモテ"
 "オモテ"
 "オモテ"
 "ウラ"
 "オモテ"
 "ウラ"
 "オモテ"
 "ウラ"
 "ウラ"
```

---

## タネ 🌾 について(seed=9999)

```julia
julia> using Random; 🌾=9999; rng = Xoshiro(🌾); rand(rng, ["オモテ", "ウラ"], 10)
10-element Vector{String}:
 "オモテ"
 "オモテ"
 "ウラ"
 "オモテ"
 "ウラ"
 "オモテ"
 "オモテ"
 "ウラ"
 "オモテ"
 "オモテ"
```

---

数字が異なれば異なる結果を出す(異なる絵を出す)

みなさんの個性から素敵なアート🎨を作ってくださいね。
