defmodule GofishWeb.Router do
  use GofishWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

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

  # Other scopes may use custom stacks.
  # scope "/api", GofishWeb do
  #   pipe_through :api
  # end
end
