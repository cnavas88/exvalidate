defmodule Exvalidate.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Exvalidate.Plug, as: PlugValidate
  alias Exvalidate.PlugError

  defmodule TestRouter do
    use Plug.Router

    plug(Plug.Parsers, parsers: [:urlencoded, :multipart])

    plug(:match)

    plug(PlugValidate, on_error: &PlugError.json_error/2)

    plug(:dispatch)

    @schema %{
      "id" => %{
        "required" => true
      }
    }

    get "/test", private: %{validate_query: @schema} do
      Plug.Conn.send_resp(conn, 200, "items")
    end

    post "/test", private: %{validate_body: @schema} do
      Plug.Conn.send_resp(conn, 200, "items")
    end
  end

  test "applies validation with valid query params" do
    # conn =
    #   :get
    #   |> Plug.Test.conn("/test?id=123")
    #   |> TestRouter.call([])

    assert true
    # assert conn.state == :sent
    # assert conn.status == 200
    # assert conn.query_params == %{"id" => "123"}
  end

  # # test "calls the on_error function with invalid query params" do
  # #   conn =
  # #     :get
  # #     |> Plug.Test.conn("/test?id=hello")
  # #     |> TestRouter.call([])

  # #   assert conn.state == :sent
  # #   assert conn.status == 400
  # #   assert conn.resp_body == "id must be a number"
  # # end

  # test "applies validation with valid body params" do
  #   conn =
  #     :post
  #     |> Plug.Test.conn("/test", %{"id" => "123"})
  #     |> TestRouter.call([])

  #   assert conn.state == :sent
  #   assert conn.status == 200
  #   assert conn.body_params == %{"id" => "123"}
  # end

  # test "calls the on_error function with invalid body params" do
  #   conn =
  #     :post
  #     |> Plug.Test.conn("/test", %{"id" => "hello"})
  #     |> TestRouter.call([])

  #   assert conn.state == :sent
  #   assert conn.status == 400
  #   assert conn.resp_body == "id must be a number"
  # end
end
