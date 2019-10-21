defmodule ExvalidateTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate

  # TODO - HACER TEST DE INTEGRACION MEJORES PARA TODOS LOS CASOS POSIBLES

  describe "Unit tests." do
    test "Not validate allowed params." do
      data = %{
        "name" => "Vegeta"
      }

      schema = %{
        "id" => %{"required" => true}
      }

      result = Exvalidate.validate(data, schema)

      assert result == {:error, "id is not allowed"}
    end

    test "Validate allowed params but not validate schema" do
      data = %{
        "id" => 12_345,
        "name" => ""
      }

      deps = %{
        validate: fn _, _, _ -> {:error, "Name is required."} end
      }

      schema = %{
        "name" => %{"required" => true}
      }

      result = Exvalidate.validate(data, schema, deps)

      assert result == {:error, "Name is required."}
    end

    test "Validate allowed params and validate schema" do
      data = %{
        "id" => 12_345,
        "name" => "Carlos"
      }

      schema = %{
        "name" => %{"required" => true}
      }

      result = Exvalidate.validate(data, schema)

      assert result == {:ok, data}
    end
  end

  describe "Functional and integration tests." do
    test "Not validate allowed params" do
      data = %{"name" => "Vegeta"}

      schema = %{"id" => %{"required" => true}}
      result = Exvalidate.validate(data, schema)

      assert result == {:error, "id is not allowed"}
    end

    test "Validate allowed params but not validate schema" do
      data = %{
        "id" => 12_345,
        "name" => ""
      }

      schema = %{
        "id" => %{"required" => false},
        "name" => %{"required" => true}
      }

      result = Exvalidate.validate(data, schema)

      assert result == {:error, "name is required."}
    end

    test "Validate allowed params and validate schema" do
      data = %{
        "id" => 12_345,
        "name" => "Carlos"
      }

      schema = %{
        "id" => %{"required" => true},
        "name" => %{"max_length" => 8}
      }

      result = Exvalidate.validate(data, schema)

      assert result == {:ok, data}
    end

    test "The rule key doesn't exists." do
      data = %{
        "id" => 12_345,
        "name" => "Carlos"
      }

      schema = %{
        "id" => %{"required" => true},
        "name" => %{"mmmmmm" => 8}
      }

      result = Exvalidate.validate(data, schema)

      assert result == {:error, "The rule 'mmmmmm' doesn't exists."}
    end
  end
end
