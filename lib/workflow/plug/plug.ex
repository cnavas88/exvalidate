defmodule Exvalidate.Plug do
  @moduledoc """
  Plug for validate request into the router file.
  """

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

  defp validate_params(conn = %Plug.Conn{private: %{validate_query: schema}}) do
    case Exvalidate.validate(conn.query_params, schema) do
      {:ok, new_params} -> {:ok, %Plug.Conn{conn | query_params: new_params}}
      {:error, message} -> {:error, message}
    end
  end

  defp validate_params(conn = %Plug.Conn{private: %{validate_body: _schema}}) do
    case Exvalidate.validate(conn.body_params, schema) do
      _ -> IO.puts ""
    end
    {:ok, conn}
  end

  defp validate_params(conn), do: {:ok, conn}
end
