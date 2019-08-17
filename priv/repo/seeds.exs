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

userA = Selfme.Repo.insert!(%Selfme.User{credits: 10, email: "alice@a.com", pass: "secret", token: "poken1"})
userB = Selfme.Repo.insert!(%Selfme.User{credits: 9, email: "bob@b.com", pass: "secret", token: "poken2"})
userC = Selfme.Repo.insert!(%Selfme.User{credits: 8, email: "charlie@c.com", pass: "secret", token: "poken3"})
userD = Selfme.Repo.insert!(%Selfme.User{credits: 7, email: "doug@d.com", pass: "secret", token: "poken4"})

experiment1userA = Selfme.Repo.insert!(%Selfme.Experiment{user_id: userA.id, payload: "ALICEIMG1"})
experiment2userA = Selfme.Repo.insert!(%Selfme.Experiment{user_id: userA.id, payload: "ALICEIMG2"})
experiment1userB = Selfme.Repo.insert!(%Selfme.Experiment{user_id: userB.id, payload: "BOBIMG1"})

aliceVotesOnBob = Selfme.Repo.insert!(
  %Selfme.Vote{experiment_id: experiment1userB.id, user_id: userA.id, attractiveness: :like, fun: :like}
)

charlieVotesOnBob = Selfme.Repo.insert!(
  %Selfme.Vote{experiment_id: experiment1userB.id, user_id: userC.id, attractiveness: :like, fun: :dislike}
)

dougVotesOnBob = Selfme.Repo.insert!(
  %Selfme.Vote{experiment_id: experiment1userB.id, user_id: userD.id, attractiveness: :meh, fun: :meh}
)

bobVotesOnAlice = Selfme.Repo.insert!(
  %Selfme.Vote{experiment_id: experiment1userA.id, user_id: userB.id, attractiveness: :dislike, fun: :like}
)