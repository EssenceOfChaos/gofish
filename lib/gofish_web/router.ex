defmodule GofishWeb.Router do
  use GofishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Gofish.Plugs.CurrentPlayer, repo: Gofish.Repo
     plug :put_player_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GofishWeb do
    pipe_through :browser # Use the default browser stack
    get "/", PageController, :index
    get "/rules", PageController, :rules
    get "/info", PageController, :info

    resources "/players", PlayerController
    ## Routes for sessions ##
  get    "/login",  SessionController, :new
  post   "/login",  SessionController, :create
  delete "/logout", SessionController, :delete
  end

  defp put_player_token(conn, _) do
    if current_player = conn.assigns[:current_player] do
        token = Phoenix.Token.sign(conn, "player socket", current_player.id)
        assign(conn, :player_token, token)
    else
      conn
    end
  end


end
