---
marp: true
theme: ./custom
paginate: true
class: invert
katex: true
---

# Lamp.jl の紹介

`@terasakisatoshi`

---

# Lamp.jl の紹介

- 正確に言えば
	- RandomLogos.jl の紹介
	- Genie.jl/GenieFramework.jl を試したお話

---

### `Lamp.jl`

- Web application that generates Logos with User Seeds
	- Backend [Genie.jl](https://github.com/GenieFramework/Genie.jl)
	- WebUI [Quasar Framework](https://quasar.dev/)
	- Image Generator: RandomLogos.jl

---


### Example

- `seed = 9`

```julia
@assert VERSION == v"1.9.3"
using Random
rng = Xoshiro(seed)
img = render(rng, ...)
display(img)
```

![bg right](https://user-images.githubusercontent.com/16760547/271754534-c773d508-0f06-4cb5-9612-f2b7743dd8d6.png)


---

### Example

- `seed = 2`

```julia
@assert VERSION == v"1.9.3"
using Random
rng = Xoshiro(seed)
img = render(rng, ...)
display(img)
```

![bg right](https://user-images.githubusercontent.com/16760547/271755863-52b37081-9083-4499-a631-b6b6bf9f5058.png)

---

# TL;DR

```console
git clone https://github.com/AtelierArith/Lamp.jl.git
cd Lamp.jl
julia --project=@. -e 'using Pkg; Pkg.instantiate()'
julia --project=@. server.jl
```

------> http://localhost:8080 <------

---

# Algorithm


- RandomLogos.jl
	- [README](https://github.com/AtelierArith/RandomLogos.jl)
	- [docs](https://atelierarith.github.io/RandomLogos.jl/dev)
	- [Pluto Notebook](https://atelierarith.github.io/julia_tutorial_pluto_materials/random_logos.html)
![bg cover](https://user-images.githubusercontent.com/16760547/244692778-87a43f0e-512f-4791-8a22-fa49ce24d546.png)


---

# Iterated Function Systems
- 反復関数系 $f(x) = W x + b, x_{n+1} = f(x_n)$ 

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

### 機械学習への応用

人工データセットで画像認識モデルの事前学習をする研究

- Kataoka, Hirokatsu, et al. [Pre-training without Natural Images](https://hirokatsukataoka16.github.io/Pretraining-without-Natural-Images/)
- Anderson, Connor, and Ryan Farrell. [Improving Fractal Pre-training](https://catalys1.github.io/fractal-pretraining/)
  - RandomLogos.jl はこの論文をベースにしている
---

### 機械学習への応用（続き)

- ほか多くの研究が進んでいるらしい
	- [Formula-Driven Supervised Learning](https://hirokatsukataoka16.github.io/Formula-Driven-Supervised-Learning-Group/)

例えば

- Takashima, Sora, et al. [Visual Atoms: Pre-training Vision Transformers with Sinusoidal Waves](https://masora1030.github.io/Visual-Atoms-Pre-training-Vision-Transformers-with-Sinusoidal-Waves/)
- Shinoda, Risa et al [SegRCDB: Semantic Segmentation via Formula-Driven Supervised Learning](https://dahlian00.github.io/SegRCDBPage/)

---

#### 色々思うこと

- 人工データセットの生成は数百万単位のデータを作るでしょ？そろそろPython で実験するのはしんどくない？

---

- Why don't you use Julia? :thinking:
	- いつ試すの？今でしょ？
	- https://github.com/AtelierArith/VisualAtom.jl

---

![bg auto](https://user-images.githubusercontent.com/16760547/271760015-de18114c-cd1a-43f9-b756-9a9252839f5f.png)

<!-- _footer: https://github.com/GenieFramework/Genie.jl-->

---

# GenieFramework.jl

- 昔触ってたけれど再度入門した. 気づいたら V5 になってる...
- ローコードで UI が作れる仕組みも開発されている
	- https://learn.genieframework.com/guides/genie-builder
- いや、テキストベースで１から始めたい
	- [Working with Genie apps (projects)](https://genieframework.github.io/Genie.jl/dev/guides/Working_With_Genie_Apps.html)

---

# [Lamp.jl](https://github.com/AtelierArith/Lamp.jl) のモチベ

- 某所で開催するイベントのためにとりあえず公開用のWebページを作る必要があった
- ナンモワカラン
- コードは公開するからプロの方, 次の JuliaTokai で発表オネシャス

---

# 必要なもの

- `app.jl`
	- routing など
- `lib/sample.jl` (外部ライブラリを使うための場所)
- `app.jl.html` 
	- VueJS, Quasar Framework で Julia のデータと連携
- 折れない強い心

```console
$ julia -e 'using GenieFramework; Genie.loadapp(); up()'
```

---

## app.jl

```julia
# app.jl
module App

using GenieFramework
@genietools

# 色々セットアップ

@app begin
    @in inputvariable
    @out outputvariable
    @onchange inputvariable begin
    	outputvariable = ...
    end
end

@page("/", "app.jl.html")

end
```

---

- `seed` を入力として受け付ける. `imageurl` が対応する出力
- 結果をブラウザで反映するために `app.jl.html` が使われる

```julia
module App

using GenieFramework
# Edit lib/sample.jl to update `Aladding module`
using ..Aladdin # 次のページで説明

@genietools

@app begin
    @in seed = 0
    @out imageurl = encode(timg)
    @onchange seed begin
        rng = Xoshiro(seed)
        # <中略>
        timg = Aladding.render!(rng, ...)
        imageurl = encode(timg)
    end
end

@page("/", "app.jl.html")

end
```

---

## `lib/sample.jl`

```julia
module Aladdin

using Random

using Images
using RandomLogos

const npoints = 100_000
const H = 384
const W = 384
const canvas = zeros(RGB{N0f8}, H, W)
const xs = Vector{Float64}(undef, npoints)
const ys = Vector{Float64}(undef, npoints)
const IFSType = RandomLogos.SigmaFactorIFS{2,Float64}
const render! = RandomLogos.render!

end
```

---

Q: ローカルパッケージに `src/Lamp.jl` に実装するのではダメなのか？
A: できた. ただし, `Genie.loadapp` がすごい遅いのでデプロイ時に失敗する
	→ 現実的な運用ではなさそう
	→ `lib` ディレクトリにコードを置いてそれらを呼び出す運用にしている

---

## `app.jl.html`

- Quasar Framework を裏で使っているらしい. Genie.jl チームは VueJS が好きっぽい.
- `q-input` や `q-img` にある `"seed"`, `"imageuri"` など
	- `app.jl` での `@in, @out, @onchange` マクロ内での Julia 変数名と対応している.

```html
<div>
    <h1>Welcome to Lamp.jl built with Genie.jl</h1>
    <h2> Input your favorite number e.g., 9 </h2>
    <q-input v-model="seed"/>
    <br>
    <p> Your seed is: {{seed}}</p>
    <q-img :src="imageurl" spinner-color="white" style="height: 500px; max-width: 500px; margin-left:auto; margin-right: auto;"></q-img>
</div>
```

---

### ローカル環境で

```console
$ cat server.jl
using GenieFramework
port = parse(Int, get(ENV, "port", "8080"))
host = get(ENV, "GENIE_HOST", "127.0.0.1")
Genie.loadapp()
up(port, host, async=false)
$ julia --project=@. server.jl
```

http://127.0.0.1:8080 へ GO!

---

# クラウド環境で動かす

技術選択は発表者の趣味。あくまでも一例

---

### GCP の Cloud Run で試す

- GCP(Google Cloud Platform)
	- クラウド環境
	- Google アカウントとクレカがあれば使うことができる
- Cloud Run
	- GCP の製品群の一つ
	- Dockerのコンテナ化をすれば大体のものは動く
		- 初めての方は Google Cloud Japan のメンバーの方が執筆された [Google Cloud Japan Advent Calendar 2022
](https://zenn.dev/google_cloud_jp/articles/12bd83cd5b3370) があるのでこれを読むと良いかも？
			- [環境構築不要でサクッと Cloud Run を試してみる](https://zenn.dev/google_cloud_jp/articles/897752dc9b1ff1)

---

#### Dockerfile をつくる


```Dockerfile
FROM julia:1.9.3
# Create and change to the app directory.
WORKDIR /app
ENV JULIA_DEPOT_PATH /app/.julia
COPY Project.toml Manifest.toml .
COPY lib ./lib
COPY config ./config
COPY app.jl app.jl.html .
COPY server.jl .

RUN julia --project=/app -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"

EXPOSE 8080
ENV JULIA_REVISE "off"
ENV GENIE_ENV "prod"
ENV GENIE_HOST "0.0.0.0"
ENV PORT "8080"

CMD ["julia", "--project=/app", "/app/server.jl"]
```

---

### コツ

- `/app` に全てをしまい込む. `JULIA_DEPOT_PATH` を `/app` 以下に配置しないと起動時にパッケージのインストールとプレコンパイルが走る → 時間の無駄
	- `GENIE_ENV` を `prod` として動かすには `config/secrets.jl` が必要になる(はず).
- イメージのビルド

```
docker build -t lampjl .
```

- Cloud Run が呼び出す Docker イメージの格納のために [Artifact Registry](https://cloud.google.com/artifact-registry/docs/overview?hl=ja#sds) に登録をする
	- Container Registry の次世代版
- [詳細はGCPのドキュメントを参照](https://cloud.google.com/artifact-registry/docs/docker/store-docker-container-images?hl=ja)


---

### サービスのデプロイ

手順は先ほど紹介した [環境構築不要でサクッと Cloud Run を試してみる](https://zenn.dev/google_cloud_jp/articles/897752dc9b1ff1) の手順を真似れば良い. 
  - `用意されたサンプル用コンテナをデプロイする` の箇所を自作の Docker イメージに置き換えれば良い.

---

### サービスの公開

- 適当な文字列として発行される
- ちゃんとしたい場合
	- ドメインを買う
	- [カスタムドメインのマッピング](https://cloud.google.com/run/docs/mapping-custom-domains?hl=ja#run) をする
	- DNS レコードうんぬんを設定する
- 色々ググって頑張れ(根性論)

---

### 動かすとわかること

- JIT コンパイル君さぁ。。。
	- そもそもサーバーレスで Julia を ry
		- あーあー聞こえない
	- Julia 1.11 など未来に期待
- Lamp.jl アプリに関して言えばユーザの入力に対しての応答がすごい速いと感じる
	- (あくまでも感想レベル)
- 一度コンパイルされたらすごい高速に動いている様子がわかる(はず)
- Web エンジニアで我こそはという方 Julia Tokai での発表お待ちしてます
