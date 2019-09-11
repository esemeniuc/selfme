# selfme
A photo feedback app in Phoenix and React

Instructions
```bash
brew install elixir postgres yarn
brew services start postgres
createuser -s postgres
```
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
      * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && yarn && cd -`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

API Interfaces
api/
queries

mutation
uploadImage

curl -X POST -F query="mutation { uploadImage(token: \"poken\", image: \"image\")}" -F image=@/Users/kaiwen.zhang/Downloads/watch.html localhost:4000/api

voteAndGetCreditBalance{
  vote(token:"poken",
  imageId: "someimage.jpg",
  attractiveness: LIKE,
  fun: DISLIKE)
}

To open postgres
`psql -d postgres`

To show all databases
`\l`

To connect a database
`\c selfme_dev`

To show schemas
`\d`

Set up your migration 
`mix ecto.migrate`

After git fetch 
`mix ecto.reset`

To test
`MIX_ENV=test mix ecto.reset && mix test`