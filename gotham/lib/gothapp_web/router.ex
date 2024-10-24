defmodule TmanWeb.Router do
  use TmanWeb, :router

  pipeline :api do
    plug(CORSPlug, origin: "*")
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  pipeline :auth do
    plug(TmanWeb.Plugs.VerifyToken)
  end

  pipeline :api_unauth do
    plug(CORSPlug, origin: "*")
    plug(:accepts, ["json"])
    plug(:fetch_session)
  end

  scope "/api/auth", TmanWeb do
    pipe_through(:api_unauth)
    post("/login", UserController, :login_user)
    post("/users", UserController, :create_user)
  end

  scope "/api", TmanWeb do
    pipe_through([:api, :auth])
    get("/users/all", UserController, :get_all_users)
    get("/users/:id", UserController, :get_user_by_id)
    get("/users", UserController, :get_user_by_email_and_username)
    put("/users/:id", UserController, :update_user)
    delete("/users/:id", UserController, :delete_user)

    get("/workingtimes/:user/:id", WorkingtimesController, :show)
    get("/workingtimes/:userID", WorkingtimesController, :get_workingtime_by_dates)
    post("/workingtimes/:userID", WorkingtimesController, :create)
    put("/workingtimes/:id", WorkingtimesController, :update)
    delete("/workingtimes/:id", WorkingtimesController, :delete)

    post("/clocks/:userID", ClockController, :create_clock)
    get("/clocks/:userID", ClockController, :get_clock_by_user_id)

    get("/teams", TeamController, :index)
    post("/teams", TeamController, :create_team)
    patch("/teams/:team_id/:user_id", TeamController, :add_user_to_team)
    get("/teams/:id", TeamController, :show)
    put("/teams/:id", TeamController, :update)
    delete("/teams/:id", TeamController, :delete)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: TmanWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
