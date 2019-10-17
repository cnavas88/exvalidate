defmodule Exvalidate.Plug do
  @moduledoc """
  Plug for validate request into the router file. For validate the request
  we need create a schema map with the rules assigned to params. 
  - Uses:
  - if the request contains query string (for GET request) the validation 
  will be: "private: %{validate_query: @schema}"
  where @schema is the map schema with the rules.

  - if the request container body params (for POST request) the validation will
  be: "private: %{validate_body: @schema}"
  where @schema is the map schema with the rules.
  """

  @spec init(list) :: list

  def init(opts), do: opts

  @spec call(%Plug.Conn{}, list) :: %Plug.Conn{}

  def call(conn, opts) do
    conn = Plug.Conn.fetch_query_params(conn)

    case validate_params(conn) do
      {:ok, conn} ->
        conn

      {:error, message} ->
        opts[:on_error].(conn, message)
    end
  end

  @spec validate_params(%Plug.Conn{}) ::
          {:ok, %Plug.Conn{}} | {:error, String.t()}

  defp validate_params(conn = %Plug.Conn{private: %{validate_query: schema}}) do
    case Exvalidate.validate(conn.query_params, schema) do
      {:ok, new_params} -> {:ok, %Plug.Conn{conn | query_params: new_params}}
      {:error, message} -> {:error, message}
    end
  end

  defp validate_params(conn = %Plug.Conn{private: %{validate_body: schema}}) do
    case Exvalidate.validate(conn.body_params, schema) do
      {:ok, new_params} -> {:ok, %Plug.Conn{conn | query_params: new_params}}
      {:error, message} -> {:error, message}
    end
  end

  defp validate_params(conn), do: {:ok, conn}
end
