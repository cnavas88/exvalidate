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
  
  describe "error message testing" do
    test ":in rule, Wrong list." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [in: 6]
      ]

      result = validate(data, schema)

      assert result == {:error, "The rule 'in' is wrong."}
    end

    test ":in rule, Not in list." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [in: ["Son goku", "Picolo"]]
      ]

      result = validate(data, schema)

      assert result == {:error, "'name' hasn't into the list '[\"Son goku\", \"Picolo\"]'."}
    end

    test ":in rule, bad value type." do
      data = %{
        "id" => 12_345,
        "name" => :picolo
      }

      schema = [
        name: [in: ["Son goku", "Picolo"]]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' has to be a String, number or list."}
    end

    test ":length rule, not equal." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [length: 7]
      ]

      result = validate(data, schema)

      assert result == {:error, "'name' length must be equal than '7'"}
    end

    test ":length rule, wrong value rule." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [length: {7}]
      ]

      result = validate(data, schema)

      assert result == {:error, "The rule 'length' is wrong."}
    end

    test ":length rule, bad value type." do
      data = %{
        "id" => 12_345,
        "name" => :picolo
      }

      schema = [
        name: [length: 7]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' has to be a String or list."}
    end

    test ":max_length rule not validate." do
      data = %{
        "id" => 12_345,
        "name" => "picolo"
      }

      schema = [
        name: [max_length: 3]
      ]

      result = validate(data, schema)

      assert result == {:error, "'name' field must be lower than or equal to '3'."}
    end

    test ":max_length rule wrong." do
      data = %{
        "id" => 12_345,
        "name" => "picolo"
      }

      schema = [
        name: [max_length: "3"]
      ]

      result = validate(data, schema)

      assert result == {:error, "The rule 'max_length' is wrong."}
    end

    test ":max_length value type wrong." do
      data = %{
        "id" => 12_345,
        "name" => 34
      }

      schema = [
        name: [max_length: 3]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' has to be a String or list."}
    end

    test ":min_length rule not validate." do
      data = %{
        "id" => 12_345,
        "name" => "picolo"
      }

      schema = [
        name: [min_length: 10]
      ]

      result = validate(data, schema)

      assert result == {:error, "'name' field must be greater than or equal to '10'."}
    end

    test ":min_length rule wrong." do
      data = %{
        "id" => 12_345,
        "name" => "picolo"
      }

      schema = [
        name: [min_length: "3"]
      ]

      result = validate(data, schema)

      assert result == {:error, "The rule 'min_length' is wrong."}
    end

    test ":min_length value type wrong." do
      data = %{
        "id" => 12_345,
        "name" => 34
      }

      schema = [
        name: [min_length: 3]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' has to be a String or list."}
    end

    test ":email validate wrong." do
      data = %{
        "id" => 12_345,
        "name" => "picolo@picolo"
      }

      schema = [
        name: [:email]
      ]

      result = validate(data, schema)

      assert result == {:error, "'picolo@picolo' is not an email."}
    end

    test ":email rule wrong." do
      data = %{
        "id" => 12_345,
        "name" => 34
      }

      schema = [
        name: [:email]
      ]

      result = validate(data, schema)

      assert result == {:error, "Email rule wrong, type 'name' is not a string."}
    end
  end

end
