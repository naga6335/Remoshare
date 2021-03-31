# <a href="https://remoshare.com/">Remoshare</a>

## アプリの概要
数ある作品の中から、ご覧いただきありがとうございます。<br>
リモートワーカー向けのガジェットナレッジ共有、職種間の繋がり促進を目的としたアプリです。
リモートワークの悩みや、他のリモートワーカーを近しい職種から探し交流を広げることができます。<br>
公式マニュアル、技術記事を参考に全て独学で開発しました。<br>

<img width="1267" alt="Remoshare_shot" src="https://user-images.githubusercontent.com/74854952/113101784-1bf81880-9238-11eb-923e-17c15b28d662.png"><br>

サイトURL・・・<a href="https://remoshare.com/">Remoshare</a>（ログイン画面からゲストユーザーとして簡単ログインできます）

## 使用技術
### フロントエンド
・HTML/CSS<br>
・Tailwindcss<br>
・Javascript(jQuery不使用)<br>
### バックエンド
・Ruby(2.7.2)<br>
・Rails(6.1.3)<br>
### 開発環境、インフラ
・Docker/docker-compose<br>
・MySQL(8.0.23)<br>
・CircleCI<br>
・Puma<br>
・Nginx<br>
・AWS(VPC、ACM、Route53、IAM、ALB、EC2、RDS、S3、CloudFront)<br>
### テスト、静的コード解析
・Rspec<br>
・Rubocop<br>
### その他、開発中意識した点
・githubでissues、プルリクを活用。機能実装を細分化し擬似チーム開発を意識した点。<br>
・プレフィックスをつけ、どのような意図でコードを書いたか可視化した点。<br>
## 特にこだわったポイント3つ
### <strong>1.直感的に動かせるUI/UX</strong><br>
年代問わず様々なユーザーに利用していただくこと、ユーザー間のスムーズな交流の促進を想定し
レイアウトを整えました。グラフに関しては、ユーザーの職種比率、改善ポイントを可視化することで、
リモートワークの課題解決へのヒントを得られそうと感じていただきたく導入しました。
また、アラート、画像のプレビュー、マイページでのタブ切り替え等javascriptで実装し、UXの向上を図っています。<br>
### <strong>2.N+1問題の解消</strong></br>
開発初期は、ページ遷移時の数秒のリロードに違和感を感じておりました。
ストレスフリーにサービスを利用して頂く上で、高速なレスポンスは大前提でサービスの信用に直結すると考えます。
上記の問題解消に取り組む中で、DBのデータ抽出メソッド、結合関係などSQLの基本を学べたと同時に
ActiveRecordのメリット、デメリットを考察することができました。今後は生のSQLの扱いに対する知識を身につけていきます。
### <strong>3.外部API導入で情報を多角から取得できるように</strong><br>
サービス内の情報のみの物差しになってしまうことで、ユーザーの選択肢に不利益を与えないように、楽天APIを導入しました。
メジャーでより多様なユーザーを抱えるサービス上での評価をすぐに確認できることで、情報収拾の利便性が高まると考えます。<br>
## Remoshareの開発背景
リモートワーク導入により、他業種、他職種の方との交流機会が減ったこと、リモートワークで仕事生産性が落ちた2点の背景から開発に至りました。<br>
前職の求人広告営業の際、緊急事態宣言後の翌日から即リモートワークに切り替わり利便性を感じた反面、リモートワークの環境整備で苦労しました。<br>
現に、リモートワークに対する悩みを抱える方々は多く、モチベーション、健康面など課題も多岐に渡ります。
ここを煩わしく感じ、今まで通りの出社スタイルに戻してしまう企業や職種も多くあったはずです。<br>
そこに対し、リモートワークを生産的に行うためのナレッジ、異職種間のリモートワーク状況を共有しあえるサービスがあれば、
多くの人々が柔軟性の高い働き方の選択やリモートだからこそ実現できる新しい職種間交流もできるのではと考え、本サービスの形になりました。<br>
## 機能一覧/詳細
### ユーザー機能（devise gem 未使用）
・新規登録、ログイン(永続ログイン)、ログアウト、ユーザー情報編集<br>
・ゲストログイン機能<br>
・管理者機能（ユーザーの削除と紐づく投稿の削除が可能）<br>
・ユーザー一覧表示
### 記事に関する機能
・投稿記事一覧、詳細表示、記事投稿、編集、削除機能<br>
・記事投稿、編集時はjavascriptで画像プレビューができる<br>
・記事詳細画面からTwitterシェアと楽天APIによる商品検索が可能<br>
・記事一覧機能にはページネーションを実装。kaminari gemを使用<br>
・記事一覧画面でChartkick gemによるユーザーの職業属性、解消した悩みジャンルの比率を可視化<br>
 投稿詳細を見てサイトを回遊して、他のユーザーと繋がっていただきたい意図があり導入。<br>
・人気タグ、いいねランキングをトップページに配置し、1ページ内で多くの情報を取得できるようにした<br>
・検索機能はgem未使用（どのようなロジックで検索できるのか1つずつ理解したかったため）<br>
・記事をタイトル、詳細、職種で曖昧検索できる<br>
### タグに関する機能
・中間テーブルの概念や扱いを学ぶためgemは不使用<br>
・タグを複数付けて登録することができる<br>
・タグをクリックすると同じタグがついた記事一覧を表示できる<br>
### フォロー機能(Ajax)
・フォロー、フォロー解除機能<br>
・フォロー、フォロワー一覧表示機能<br>
### いいね機能(Ajax)
・記事にいいねができる機能<br>
・いいねをした記事のいいね数が変化する<br>
・いいねを押した記事一覧表示機能<br>
・いいね数の多い記事上位3つをトップページに表示<br>
### コメント機能(Ajax)
・記事ごとにコメント投稿、削除、表示する機能<br>
### DM機能(Ajax)
・1対1のチャットルームを作成できる<br>
・メッセージ送信、削除機能<br>
・DM中のユーザー一覧をマイページ内に表示<br>
### 通知機能
・コメント、フォロー、いいねが他ユーザーからあった場合通知一覧に表示。記事、ユーザー詳細に遷移できる<br>
・通知があった際、通知マークが付く<br>
・通知一括削除機能<br>
### 製品検索機能
・楽天商品検索APIを使用<br>
・検索結果から画像、価格、平均レビューの表示、楽天のサイトへ遷移が可能<br>
### その他機能
・全ページ完全レスポンシブ対応<br>
・アラートは右からスライドインし2秒後にフェードアウト(javascriptで実装)<br>
・プロフィール、記事投稿、編集の詳細入力部の文字カウンター(javascriptで実装)<br>
・要素ホバーでせり出すアニメーション(Tailwindcssで実装)<br>
## インフラ構成
![AWS](https://user-images.githubusercontent.com/74854952/112935694-38745200-915f-11eb-8fea-acea1cad292d.png)
## ER図
![ER図]![ER図 (1)](https://user-images.githubusercontent.com/74854952/113102829-7fcf1100-9239-11eb-821b-6c7ff7274809.png)
## 今後の改良計画
・Vuejsによる部分SPA化、UXの向上（いいね、フォローなどのボタンアニメーション）<br>
・DM受信時の通知も適用<br>
・Request、Systemspec周りのテストを追加<br>

#### 長文にも関わらず最後までご覧いただき、ありがとうございました。今後はエンジニアとしての技術のキャッチアップに努めることは勿論、1人のビジネスマンとして世の中の課題に対し当事者意識を持ち、サービスの開発に携わっていきます。
