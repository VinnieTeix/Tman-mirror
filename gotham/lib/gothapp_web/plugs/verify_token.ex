defmodule TmanWeb.Plugs.VerifyToken do
  import Plug.Conn
  import Phoenix.Controller
  alias Tman.Auth.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_token(conn) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Token not found"})

      token ->
        case verify_token(token) do
          {:ok, _claims} ->
            conn

          {:error, _reason} ->
            conn
            |> put_status(:unauthorized)
            |> json(%{error: "Invalid token"})
        end
    end
  end

  defp get_token(conn) do
    case get_req_header(conn, "authorization") do
      [token] -> token
      _ -> nil
    end
  end

  defp verify_token(token) do
    token = String.slice(token, 7..String.length(token))
    Token.verify_and_validate(token)
  end
end
