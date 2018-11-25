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
### Blue 環境用のアプリケーション修正

- 出力メッセージに "Blue" を追加

<details><summary>編集済みソースコード</summary>

```
@GetMapping("/")
String hello() {
    return "Hello, World! Blue";
}
```
</details>

#### Blue 環境用のアプリケーションをデプロイ
以下のコマンドでビルド＆デプロイを行います。

```
$ ./gradlew clean build -x test
$ cf push
```

#### Blue 環境用のアプリケーションの動作確認
以下のコマンドで定期的にアプリケーションにアクセスし動作確認をします。

```
$ while true; do curl -s http://<アプリケーションURL>; echo; sleep 1;done
```

<details><summary>実行結果</summary>

```
Hello, World! Blue
Hello, World! Blue
Hello, World! Blue
Hello, World! Blue
Hello, World! Blue
Hello, World! Blue
```
</details>

### Green 環境用のアプリケーション修正

- 出力メッセージに "Green" を追加

<details><summary>編集済みソースコード</summary>

```
@GetMapping("/")
String hello() {
    return "Hello, World! Green";
}
```
</details>

#### Green 環境用のアプリケーションをデプロイ
以下のコマンドでビルド＆デプロイを行います。
Manifest.yml に定義しているアプリケーション名を上書きしてデプロイを行います。

```
$ ./gradlew clean build -x test
$ cf push hello-pcf-green
```

#### アプリケーションの確認
デプロイ済みのアプリケーションを `cf apps` コマンドで確認します。

```
$ cf apps

syanagihara@pivotal.io として組織 syanagihara-org / スペース development 内のアプリを取得しています...
OK

名前              要求された状態   インスタンス   メモリー   ディスク   URL
hello-pcf         started          1/1            1G         1G         hello-pcf-active-mouse.cfapps.io
hello-pcf-green   started          1/1            1G         1G         hello-pcf-green-daring-mandrill.cfapps.io
```


## まとめ / 振り返り
