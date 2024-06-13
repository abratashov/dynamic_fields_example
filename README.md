# README

Rails app that demonstrates Dynamic Fields implementation with Postgres JSON

## Installation

```sh
asdf install
pg_ctl start
bundle
# check and fix 'config/database.yml' for your local PG settings
rails db:drop db:create db:migrate db:seed
rails s
```

# Postman

```json
// PUT http://localhost:3000/api/v1/users/10e39614-aabf-4a8d-bb27-a6a91b194e5d

// Update
{
  "user": {
    "user_info": {
      "data": {
        "name": "Jack",
        "phone": 123456789,
        "gender": "male",
        "languages": [ "uk", "ru" ]
      }
    }
  }
}

// Merge
{
  "user": {
    "user_info": {
      "merge": "true",
      "data": {
        "name": "Jane",
        "phone": 777555333,
        "gender": "female"
      }
    }
  }
}
```
