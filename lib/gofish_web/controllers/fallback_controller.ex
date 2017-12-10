defmodule GofishWeb.FallbackController do
  use GofishWeb, :controller


    def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
      conn
      |> put_status(:unprocessable_entity)
      |> render(GofishWeb.ChangesetView, "error.json", changeset: changeset)
    end

    def call(conn, {:error, :not_found}) do
      conn
      |> put_status(:not_found)
      |> render(GofishWeb.ErrorView, :"404")
    end



end
