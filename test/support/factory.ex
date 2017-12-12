defmodule Gofish.Factory do
  use ExMachina.Ecto, repo: Gofish.Repo
  alias Gofish.Accounts.Player

  def player_factory do
    %Player{

      email: "batman@example.com",
      username: "cooldude17",
      rank: 65,
      password_hash: "ASDLKFJAOIEAO394873948"
    }
  end
end
