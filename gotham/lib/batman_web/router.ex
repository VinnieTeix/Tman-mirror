defmodule TodolistWeb.Router do
  use TodolistWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", TodolistWeb do
    pipe_through(:api)

    get("/users", UserController, :index)
    get("/users/:userID", UserController, :show)
    post("/users", UserController, :create)
    put("/users/:userID", UserController, :update)
    delete("/users/:userID", UserController, :delete)

    get("/workingtime/:user_id", WorkingTimeController, :index)
    get("/workingtime/:user_id/:id", WorkingTimeController, :show)
    post("/workingtime/:user_id", WorkingTimeController, :create)
    put("/workingtime/:id", WorkingTimeController, :update)
    delete("/workingtime/:id", WorkingTimeController, :delete)

    get("/clocks/:user_id", ClockController, :index)
    post("/clocks/:user_id", ClockController, :create)
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:batman, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: TodolistWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
