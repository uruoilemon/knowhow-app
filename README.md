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
| user_id   | references | null: false, foreign_key: true |
| post_id   | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


## postsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| text        | text       | null: false                    |
| answer      | text       |                                |
| user_id     | references | null: false, foreign_key: true |


### Association
- belongs_to :user
- has_many :comments
- has_many :post_tag_relations


## tagsテーブル

| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| name                  | string     | null: false, uniqueness: true  |
| post_tag__relation_id | references | null: false, foreign_key: true |

### Association
- has_many :post_tag_relations


## post_tag_relationsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| post_id     | references | null: false, foreign_key: true |
| tag_id      | references | null: false, foreign_key: true |

### Association
- belongs_to :post
- belongs_to :tag