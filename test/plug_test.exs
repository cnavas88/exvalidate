defmodule Exvalidate.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Exvalidate.Plug, as: PlugValidate
  alias Exvalidate.PlugError

  defmodule TestRouterJson do
    use Plug.Router

    plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
    plug(:match)
    plug(PlugValidate, on_error: &PlugError.json_error/2)
    plug(:dispatch)

    @schema %{
      "id" => %{"required" => true}
    }

    get "/test", private: %{validate_query: @schema} do
      Plug.Conn.send_resp(conn, 200, "")
    end

    post "/test", private: %{validate_body: @schema} do
      Plug.Conn.send_resp(conn, 200, "")
    end
  end

  defmodule TestRouterPlainText do
    use Plug.Router

    plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
    plug(:match)
    plug(PlugValidate, on_error: &PlugError.plain_error/2)
    plug(:dispatch)

    @schema %{
      "id" => %{"required" => true}
    }

    get "/test", private: %{validate_query: @schema} do
      Plug.Conn.send_resp(conn, 200, "")
    end

    post "/test", private: %{validate_body: @schema} do
      Plug.Conn.send_resp(conn, 200, "")
    end
  end

  describe "Testing plug with json errors" do
    test "QueryString validation with valid query params" do
      conn =
        :get
        |> Plug.Test.conn("/test?id=123")
        |> TestRouterJson.call([])
  
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.query_params == %{"id" => "123"}
      assert conn.resp_body == ""
    end
  
    test "QueryString Validation error" do
      conn =
        :get
        |> Plug.Test.conn("/test?id=&name=Boo")
        |> TestRouterJson.call([])
  
      assert conn.state == :sent
      assert conn.status == 400
      assert conn.query_params == %{"id" => "", "name" => "Boo"}
      assert Jason.decode!(conn.resp_body) == %{"error" => "id is required."}
    end
  
    test "Body validation with valid body params" do
      conn =
        :post
        |> Plug.Test.conn("/test", %{"id" => "123"})
        |> TestRouterJson.call([])
  
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.body_params == %{"id" => "123"}
    end
  
    test "Body validation error" do
      conn =
        :post
        |> Plug.Test.conn("/test", %{"id" => ""})
        |> TestRouterJson.call([])
  
      assert conn.state == :sent
      assert conn.status == 400
      assert conn.body_params == %{"id" => ""}
      assert Jason.decode!(conn.resp_body) == %{"error" => "id is required."}
    end  
  end

  describe "Testing plug with text plain errors" do
    test "QueryString validation with valid query params" do
      conn =
        :get
        |> Plug.Test.conn("/test?id=123")
        |> TestRouterPlainText.call([])
  
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.query_params == %{"id" => "123"}
      assert conn.resp_body == ""
    end
  
    test "QueryString Validation error" do
      conn =
        :get
        |> Plug.Test.conn("/test?id=&name=Boo")
        |> TestRouterPlainText.call([])
  
      assert conn.state == :sent
      assert conn.status == 400
      assert conn.query_params == %{"id" => "", "name" => "Boo"}
      assert conn.resp_body == "id is required."
    end
  
    test "Body validation with valid body params" do
      conn =
        :post
        |> Plug.Test.conn("/test", %{"id" => "123"})
        |> TestRouterPlainText.call([])
  
      assert conn.state == :sent
      assert conn.status == 200
      assert conn.body_params == %{"id" => "123"}
    end
  
    test "Body validation error" do
      conn =
        :post
        |> Plug.Test.conn("/test", %{"id" => ""})
        |> TestRouterPlainText.call([])
  
      assert conn.state == :sent
      assert conn.status == 400
      assert conn.body_params == %{"id" => ""}
      assert conn.resp_body == "id is required."
    end  
  end
end
