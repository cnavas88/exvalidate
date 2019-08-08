defmodule Exvalidate.Plug do
  @moduledoc false

  def init(opts), do: opts

  def call(conn, opts) do
    conn = Plug.Conn.fetch_query_params(conn)

    case validate_params(conn) do
      {:ok, conn} ->
        conn

      {:error, message} ->
        opts[:on_error].(conn, message)
    end
  end

  defp validate_params(conn = %Plug.Conn{private: %{validate_query: _schema}}) do
    IO.puts "VALIDATE QUERY PARAMS"
    {:ok, conn}
  end
  defp validate_params(conn = %Plug.Conn{private: %{validate_body: _schema}}) do
    IO.puts "VALIDATE BODY PARAMS"
    {:ok, conn}
  end
  defp validate_params(conn), do: {:ok, conn}

end
