### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ f1d2f741-7774-460c-87e7-9b2f2cfa3d9f
begin
	# Extras
	using Test
	using StableRNGs
end

# ╔═╡ f786af1c-bb14-482b-8d6c-cf204f2d71da
md"""
# 修正グラムシュミットの直交化
"""

# ╔═╡ 18c479b4-c714-472b-abad-b03cc6afb206
begin
    function innerproduct(a::AbstractVector, b::AbstractVector)
        s = zero(eltype(a))
        @inbounds for i in eachindex(a, b)
            s += a[i] * b[i]
        end
        s
    end
    const ⋅ = innerproduct
    norm(a::AbstractVector) = √(a ⋅ a)
end

# ╔═╡ 393e5b2d-c126-4827-9d91-b0539dfc02f1
begin
    @testset "innerproduct" begin
        rng = StableRNG(999)
        x = rand(rng, 2)
        y = rand(rng, 2)

        @test innerproduct(x, y) == innerproduct(y, x)
        @test x ⋅ y == y ⋅ x

        @test innerproduct([1, 0], [0, 1]) == 0
        @test innerproduct([0, 1], [1, 0]) == 0
        @test innerproduct([1, 1], [1, 1]) ≈ norm([1, 1])^2 ≈ 2.0
    end

    @testset "norm" begin
        @test norm([0.0, 0.0]) == 0
        @test norm([1.0, 1.0]) == √2
        @test norm([1.0, 2.0]) == √5
        @test norm([2.0, 1.0]) == √5
    end
    nothing
end

# ╔═╡ 532c14fe-bede-46b5-8888-a7045fd8d93c
struct ModifiedGramSchmidt end # Algorithm

# ╔═╡ 40e2ae0c-d2af-11ee-31c9-dfa8f7798362
function orthonormalize(::Type{ModifiedGramSchmidt}, A)
	a₁ = A[:, 1]
	m = size(A, 2)
	r₁₁ = norm(a₁)
	q₁ = a₁ / r₁₁
	Q = similar(A)
	R = similar(A, m, m)
	Q[:, 1] .= q₁
	R[1,1] = r₁₁
	for n in 1:(m-1)
		aₙ₊₁ = @view A[:, n+1]
		for i in 1:n
			qᵢ = @view Q[:, i]
			rᵢ₍ₙ₊₁₎ = qᵢ ⋅ aₙ₊₁
			R[i, n+1] = rᵢ₍ₙ₊₁₎
			@. aₙ₊₁ = aₙ₊₁ - rᵢ₍ₙ₊₁₎ * qᵢ
		end
		r₍ₙ₊₁₎₍ₙ₊₁₎ = norm(aₙ₊₁)
		R[n+1,n+1] = r₍ₙ₊₁₎₍ₙ₊₁₎
		qₙ₊₁ = aₙ₊₁ / r₍ₙ₊₁₎₍ₙ₊₁₎
		Q[:, n+1] .= qₙ₊₁
	end
	Q, R
end

# ╔═╡ bee5f314-e6dd-48bb-8a57-d12b4d289032
@testset "ModifiedGramSchmidt" begin
    rng = StableRNG(123)
    A = rand(rng, 10, 10)

    Q, R = orthonormalize(ModifiedGramSchmidt, copy(A))
	@test A ≈ Q*R
	q1 = Q[:, 1]
	q2 = Q[:, 2]
	q3 = Q[:, 3]

    @test innerproduct(q1, q1) ≈ 1.0
    @test innerproduct(q2, q2) ≈ 1.0
    @test innerproduct(q3, q3) ≈ 1.0

    @test abs(innerproduct(q1, q2)) ≈ 0.0 atol = 1e-14
    @test abs(innerproduct(q2, q3)) ≈ 0.0 atol = 1e-14
    @test abs(innerproduct(q1, q3)) ≈ 0.0 atol = 1e-14

    @test abs(innerproduct(q1, q2)) ≈ 0.0 atol = 1e-16
    @test_broken abs(innerproduct(q2, q3)) ≈ 0.0 atol = 1e-16
    @test_broken abs(innerproduct(q1, q3)) ≈ 0.0 atol = 1e-16
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
StableRNGs = "860ef19b-820b-49d6-a774-d7a799459cd3"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
StableRNGs = "~1.0.1"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.1"
manifest_format = "2.0"
project_hash = "a4590486d7604ab3578478648d997eb50013d5ca"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.StableRNGs]]
deps = ["Random", "Test"]
git-tree-sha1 = "ddc1a7b85e760b5285b50b882fa91e40c603be47"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
"""

# ╔═╡ Cell order:
# ╟─f786af1c-bb14-482b-8d6c-cf204f2d71da
# ╠═f1d2f741-7774-460c-87e7-9b2f2cfa3d9f
# ╠═18c479b4-c714-472b-abad-b03cc6afb206
# ╠═393e5b2d-c126-4827-9d91-b0539dfc02f1
# ╠═532c14fe-bede-46b5-8888-a7045fd8d93c
# ╠═40e2ae0c-d2af-11ee-31c9-dfa8f7798362
# ╠═bee5f314-e6dd-48bb-8a57-d12b4d289032
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
