defmodule Exvalidate.PlugError do
  @moduledoc """
  Define the error functions for the plug. We can choose return errors in the
  next formats:
  - Json: using the json_error function.
  - Plain Text: using the plain_error function.

  If you want create a custom error function, you can define this function
  in a module and then call the plug validate:

  plug(PlugValidate, on_error: &PlugError.json_error/2)

  You set the "on_error" param with the your custom function.
  """

  @spec json_error(%Plug.Conn{}, String.t()) :: %Plug.Conn{}

  def json_error(conn, error_message) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> Plug.Conn.send_resp(400, jsonable(error_message))
    |> Plug.Conn.halt()
  end

  @spec plain_error(%Plug.Conn{}, String.t()) :: %Plug.Conn{}

  def plain_error(conn, error_message) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "text/plain")
    |> Plug.Conn.send_resp(400, error_message)
    |> Plug.Conn.halt()
  end

  @spec jsonable(String.t()) :: String.t()

  defp jsonable(msg), do: Jason.encode!(%{"error" => msg})
end
