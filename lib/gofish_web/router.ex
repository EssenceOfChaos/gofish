defmodule GofishWeb.Router do
  use GofishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Gofish.Plugs.CurrentPlayer, repo: Gofish.Repo
    # plug :fetch_current_player
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

  ## PLUG FETCH CURRENT PLAYER ##
  # defp fetch_current_player(conn, _) do
  #   assign(conn, :current_player, get_session(conn, :current_player))
  # end
  

end
