defmodule Gofish.Factory do
  use ExMachina.Ecto, repo: Gofish.Repo

  def player_factory do
    %Gofish.Player{

      email: "batman@example.com",
      username: "dude-so-cool",
      rank: 65,
      password_hash: "ASDLKFJAOIEAO394873948"
    }
  end
end
