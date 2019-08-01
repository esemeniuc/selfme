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

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
