# intro2software_with_julia_pluto_materials

[計算物理春の学校 2024](https://atelierarith.github.io/intro2software_with_julia/) の Pluto Notebook 置き場

# 使い方

- Julia をインストールする．Git をインストールする
- 次のようにしてリポジトリをクローン，Pluto.jl をインストールする

```console
$ git clone https://github.com/AtelierArith/intro2software_with_julia_pluto_materials
$ cd intro2software_with_julia_pluto_materials
$ julia -e 'using Pkg; Pkg.add("Pluto")'
```

Pluto.jl は Julia のためのリアクティブなノートブックを提供するパッケージである．次のコマンドを実行すると Pluto Notebook 環境が起動する:

```console
$ julia -e 'using Pluto; Pluto.run()'
```

Pluto.jl 自体のドキュメントは https://github.com/fonsp/Pluto.jl/wiki にある．
