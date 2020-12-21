# MATCHING-AC

電気工事士・企業が資格を通じてマッチング出来るサイトです。
就活用のポートフォリオです。

# リンク

- 本アプリ :https://www.matching-ac.tk/

# 使用技術

- Ruby 2.5.8

- Ruby on Rails 5.2.4

- PostgreSQL

- AWS
 - EC2/ALB
 - RDS for PostgreSQL
 - Certificate Manager(ACM)

- Docker
 - webコンテナ「nginx」
 - appコンテナ「puma rails」
 - dbコンテナ「PostgreSQL」

- rubocop

- RSpec

# 機能一覧

- ユーザー登録、ログイン機能全般(devise)
- フォロー機能
- ユーザー検索機能(ransack)
- メッセージ機能
- 他サイトからHTML情報取得(Mechanize)
- ページネーション機能(kaminari)
