defmodule ExvalidateTest do
  use ExUnit.Case
  doctest Exvalidate

  use Exvalidate

  describe "validate/3." do
    test "Not allowed params." do
      data = %{
        "name" => "Vegeta"
      }

      schema = [
        id: [:required],
        name: [:required, length: 6]
      ]

      result = validate(data, schema)

      assert result == {:error, "id is not allowed."}
    end

    test "Allowed params but not validate schema." do
      data = %{
        "id" => 12_345,
        "name" => ""
      }

      validate_fn = fn _, _ ->
        {:error, {:required, :required_value_wrong}}
      end

      schema = [
        name: [:required]
      ]

      result = validate(data, schema, validate_fn)

      assert result == {:error, "The field 'name' is required."}
    end

    test "Allowed params and validate schema" do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [:required]
      ]

      validate_fn = fn _, _ ->
        {:ok, "Vegeta"}
      end

      result = validate(data, schema, validate_fn)

      assert result == {:ok, data}
    end
  end
  
  describe "message testing" do
    # MESSAGES
  end
end
