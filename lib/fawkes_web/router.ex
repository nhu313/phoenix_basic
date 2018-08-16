defmodule FawkesWeb.Router do
  use FawkesWeb, :router

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

  scope "/", FawkesWeb do
    pipe_through :browser # Use the default browser stack

    get "/about", PageController, :about
    get "/", PageController, :index

    get "/categories/new", CategoryController, :new
    post "/categories/create", CategoryController, :create
    get "/categories", CategoryController, :index

    resources "/speakers", SpeakerController
    resources "/schedule_slots", SlotController
    resources "/locations", LocationController
    resources "/audiences", AudienceController
    resources "/talks", TalkController
    resources "/events", EventController
  end

  # Other scopes may use custom stacks.
  # scope "/api", FawkesWeb do
  #   pipe_through :api
  # end
end
