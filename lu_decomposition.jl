### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 39c948c0-d2b8-11ee-2147-5fd144b963fe
using Random

# ╔═╡ 1c9983f8-b302-40c6-a1e4-c4ba89e738fb
begin
	function decomposeLU!(A)
		n = size(A, 1)

		for k in 1:n-1
			a_kk = A[k, k]
			w = inv(a_kk)
			for i in (k+1):n
				A[i, k] = A[i, k] * w
				for j in (k+1):n
					A[i, j] = A[i, j] - A[i, k] * A[k, j]
				end
			end
		end

		L = zero(A)
		U = zero(A)
		for i in 1:size(A, 1)
			L[i, i] = one(eltype(A))
			for j in 1:(i-1)
				L[i, j] = A[i, j]
			end
			for j in i:size(A, 2)
				U[i, j] = A[i, j]
			end
		end
		L, U
	end
	
	decomposeLU(A) = decomposeLU!(copy(A))
end

# ╔═╡ 012cb058-b91b-4c24-bc4b-fef115f97d58
begin
	rng = Xoshiro(123)
	A = rand(rng, 5, 5)
	L, U = decomposeLU(A)
end

# ╔═╡ dfec4cf8-c864-48b8-adbf-0eb96059134a
L

# ╔═╡ 95fed2cf-60ce-4fd6-a599-107d55dec1a1
U

# ╔═╡ ef3d07dd-7cb5-4c89-9c8c-5ab563d4fbb2
L * U

# ╔═╡ 9b26bea2-98ee-4125-a1bd-f58cac980c3d
L * U

# ╔═╡ e8307483-95e4-4213-be4b-7c54ef1847f4
A ≈ L * U

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.2"
manifest_format = "2.0"
project_hash = "fa3e19418881bf344f5796e1504923a7c80ab1ed"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"
"""

# ╔═╡ Cell order:
# ╠═39c948c0-d2b8-11ee-2147-5fd144b963fe
# ╠═1c9983f8-b302-40c6-a1e4-c4ba89e738fb
# ╠═012cb058-b91b-4c24-bc4b-fef115f97d58
# ╠═dfec4cf8-c864-48b8-adbf-0eb96059134a
# ╠═95fed2cf-60ce-4fd6-a599-107d55dec1a1
# ╠═ef3d07dd-7cb5-4c89-9c8c-5ab563d4fbb2
# ╠═9b26bea2-98ee-4125-a1bd-f58cac980c3d
# ╠═e8307483-95e4-4213-be4b-7c54ef1847f4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
