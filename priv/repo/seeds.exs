# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Gofish.Repo.insert!(%Gofish.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Gofish.Repo

Repo.insert!(%Gofish.Accounts.Player{
  username: "BigDaDDy",
  email: "comegetsome1999@hotmail.com",
  rank: 84,
  password_hash: "Argon2_abcdefghijk123"
})