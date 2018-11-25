# Blue Green デプロイメント
Pivotal Cloud Foundry の機能を使用して、[Blue Green デプロイメント](https://martinfowler.com/bliki/BlueGreenDeployment.html)を行います。

## 概要 / 説明
Blue Green デプロイメントとは、Blue 環境と Green 環境の２つの環境を用意しておき、それらの環境へのルーティングを切り替える事でダウンタイムリスクを軽減するデプロイ方法です。

Pivotal Cloud Foundry では、`cf map-route` と `umnap-route` コマンドを使用してルーティング設定を行うことができます。
これらのコマンドによるルーティング設定により、Blue Green デプロイメントを実現します。


## 前提 / 環境
- [Java アプリケーションのデプロイ](https://github.com/shinyay/pcf-workshop-deploy-java/blob/master/README.md)
  - [事前作業](https://github.com/shinyay/pcf-workshop-prerequisite/blob/master/README.md)

## 手順 / 解説
#### Blue 環境用のアプリケーション修正

- 出力メッセージに "Blue" を追加

<details><summary>編集済みソースコード</summary>

```
@GetMapping("/")
String hello() {
    return "Hello, World! Blue";
}
```
</details>

## まとめ / 振り返り
