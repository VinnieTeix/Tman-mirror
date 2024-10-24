defmodule Tman.Auth.Token do
  use Joken.Config

  @default_ttl 30 * 24 * 60 * 60

  def generate_token(claims \\ %{}) do
    Joken.generate_and_sign!(claims, ttl: @default_ttl)
  end
end
