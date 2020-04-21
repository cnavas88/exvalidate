defmodule Exvalidate.Plug do
  @moduledoc """
  Plug for validate request into the router file. For validate the request
  we need create a schema keywordlist with the rules assigned to params. 
  
  ## Uses
  1- To add the exvalidate middleware in your plug file:
  ```
  plug(:match)
  plug(PlugValidate, on_error: &PlugError.json_error/2)
  plug(:dispatch)
  ```

  2- Schema example:
  ```
  @schema = [
    name: [between: {2, 16}]
  ]
  ```

  3a- if the request contains query string (for GET request) the validation 
  will be: "private: %{validate_query: @schema}"
  
  ```
  get "/test", private: %{validate_query: @schema} do
  ```

  3b- if the request container body params (for POST request) the validation will
  be: "private: %{validate_body: @schema}"
  
  ```
  post "/test", private: %{validate_body: @schema} do
  ```
  """
  use Exvalidate

  @spec init(list) :: list

  @doc false
  def init(opts), do: opts

  @spec call(%Plug.Conn{}, list) :: %Plug.Conn{}

  @doc false
  def call(conn, opts) do
    conn = Plug.Conn.fetch_query_params(conn)

    case validate_params(conn) do
      {:ok, conn} ->
        conn

      {:error, message} ->
        opts[:on_error].(conn, message)
    end
  end

  defp validate_params(%Plug.Conn{private: %{validate_query: schema}} = conn) do
    call_to_validate(conn.query_params, schema, conn)
  end

  defp validate_params(%Plug.Conn{private: %{validate_body: schema}} = conn) do
    call_to_validate(conn.body_params, schema, conn)
  end

  defp validate_params(_conn), do: {:error, :invalid_validate}

  defp call_to_validate(params, schema, conn) do
    case validate(params, schema) do
      {:ok, new_params} ->
        {:ok, %Plug.Conn{conn | query_params: new_params}}

      {:error, message} ->
        {:error, message}
    end
  end
end
