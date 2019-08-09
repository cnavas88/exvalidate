defmodule Exvalidate.PlugError do
  @moduledoc """

  """
  def json_error(conn, error_message) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "application/json")
    |> Plug.Conn.send_resp(400, jsonable(error_message))
    |> Plug.Conn.halt()
  end

  def plain_error(conn, error_message) do
    conn
    |> Plug.Conn.put_resp_header("content-type", "text/plain")
    |> Plug.Conn.send_resp(400, error_message)
    |> Plug.Conn.halt()
  end

  defp jsonable(msg), do: Jason.encode!(%{"error" => msg})
end
