# テーブル設計

## usersテーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| name       | string | null: false |
| email      | string | null: false |
| password   | string | null: false |
| nickname   | string | null: false |
| department | string | null: false |


### Association
- has_many :comments
- has_many :posts


## commentsテーブル

| Column    | Type       | Options                        |
| ------    | ---------- | ------------------------------ |
| text      | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| post      | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


## postsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| text        | text       | null: false                    |
| answer      | text       |                                |
| user        | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_many :comments
