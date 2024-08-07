### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 8c13dea2-1a84-11ee-117d-d5937495696f
begin
	using Pkg
	Pkg.activate(; temp=true)
	Pkg.add(Pkg.PackageSpec(
		url="https://github.com/AtelierArith/RandomLogos.jl", 
		rev="f794a1b",
	))
	Pkg.add("ImageShow")
	Pkg.add("ImageCore")
	
	using Random
	using ImageCore
	using ImageShow
	
	import RandomLogos
	using RandomLogos: render
	using RandomLogos: Config
end

# ╔═╡ f99fbad8-5165-4083-9aab-cde62eaf3ec3
md"""

# RandomLogos.jl で遊んでみる

野良パッケージを Pluto.jl の上で動かす例として RandomLogos.jl を用いることにする． これは [Connor Anderson と Ryan Farrell による特異値分解による反復関数系のサンプリングアルゴリズム](https://catalys1.github.io/fractal-pretraining/) の Julia 実装を提供している．

- ソースコード: https://github.com/AtelierArith/RandomLogos.jl/tree/main
- ドキュメント: https://atelierarith.github.io/RandomLogos.jl/dev/

"""

# ╔═╡ fe1047ef-d512-4db7-bc49-bb5bc5e8bba9
let
	canvas = RandomLogos.render(
		joinpath(pkgdir(RandomLogos), "examples", "config_mt.toml")
	)
	canvas
end

# ╔═╡ a900e785-7780-496d-8426-d0e668e9531c
let
	configpath = joinpath(pkgdir(RandomLogos), "examples", "config_mt.toml")
	config = Config(configpath)
	logos = Matrix{RGB{N0f8}}[]
	for s in 1:25
	    rng = MersenneTwister(999 + s)
	    ifs = rand(rng, RandomLogos.SigmaFactorIFS{2})
	    rng = MersenneTwister(999 + 2s)
	    canvas = render(rng, ifs, config)
	    push!(logos, canvas)
	end
	
	reshape(logos, 5, 5)
end

# ╔═╡ Cell order:
# ╟─f99fbad8-5165-4083-9aab-cde62eaf3ec3
# ╠═8c13dea2-1a84-11ee-117d-d5937495696f
# ╠═fe1047ef-d512-4db7-bc49-bb5bc5e8bba9
# ╠═a900e785-7780-496d-8426-d0e668e9531c
