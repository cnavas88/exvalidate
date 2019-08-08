defmodule Exvalidate.Plug do
  @moduledoc false

  def init(opts), do: opts

  def call(conn, opts) do
    result = conn
    |> Plug.Conn.fetch_query_params()
    |> validate_params()

    case result do
      {:ok, conn} -> conn
      {:error, message} -> opts[:on_error].(conn, message)
    end
  end

  defp validate_params(conn = %Plug.Conn{private: %{validate_query: schema}}) do
    IO.puts "VALIDATE QUERY PARAMS"
    {:ok, conn}
  end

  defp validate_params(conn = %Plug.Conn{private: %{validate_body: schema}}) do
    IO.puts "VALIDATE BODY PARAMS"
    {:ok, conn}
  end

  defp validate_params(conn), do: {:ok, conn}

end
