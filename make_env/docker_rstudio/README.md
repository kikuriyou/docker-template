# 環境構築(RStudio)

## 含まれているパッケージ
- ベースイメージ:
    - [rocker/tidyverse](https://hub.docker.com/r/rocker/tidyverse)
- 追加パッケージ: 
    - broom 
    - haven 
    - cobalt 
    - WeightIt 
    - MatchIt 
    - Matching 
    - doParallel 
    - caret

## 構築手順
ワークディレクトリに入る
```
cd docker_rstudio
```

Dockerコンテナを起動
```
./docker.sh start
```

ブラウザで `localhost:8787` にアクセスして RStudio を開く

コンテナを閉じる場合は
```
./docker.sh stop
```
