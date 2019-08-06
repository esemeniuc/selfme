# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Selfme.Repo.insert!(%Selfme.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


image = %Selfme.Image{payload: "asdafads"}
image = Selfme.Repo.insert!(image)

user = %Selfme.User{credits: 1, email: "aaa@a.com", pass: "secret", token: "poken"}
user = Selfme.Repo.insert!(user)

vote = %Selfme.Vote{image_id: image.id, user_id: user.id, attractiveness: :like, fun: :meh}
Selfme.Repo.insert!(vote)