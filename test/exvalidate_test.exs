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

  describe "when we got an error of validator, we test show and hide message options." do
    setup do
      previous_env = Application.get_env(:exvalidate, :show_messages)
      on_exit(fn ->  
        Application.put_env(:exvalidate, :show_messages, previous_env)
      end)
    end

    test "we don't want to translate a atom error to message" do
      Application.put_env(:exvalidate, :show_messages, false)

      data = %{"id" => 12_345, "name" => "Vegeta"}

      schema = [name: [in: 6]]

      result = validate(data, schema)

      assert result == {:error, :in_rule_wrong}
    end

    test ":in rule, wrong list." do
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

    test ":in rule, not value in a list." do
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

    test ":in rule, the value type is bad." do
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

    test ":length rule, isn't equal." do
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

    test "The rule doesn't exists." do
      data = %{
        "id" => 12_345,
        "name" => 34
      }

      schema = [
        name: [:wrong_rule]
      ]

      result = validate(data, schema)

      assert result == {:error, "The rule 'wrong_rule' doesn't exists."}
    end

    test "Not accepted rule wrong." do
      data = %{
        "id" => 12_345,
        "name" => :vegeta
      }

      schema = [
        name: [:accepted]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' is not accepted."}
    end

    test "Type validate value wrong." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [type: :float]
      ]

      result = validate(data, schema)

      assert result == {:error, "'name' must be type ':float'."}
    end

    test "Type validate wrong." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [type: "float"]
      ]

      result = validate(data, schema)

      assert result == {:error, "The type rule must be an atom."}
    end

    test "Type value not supported." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [type: :function]
      ]

      result = validate(data, schema)

      assert result ==
               {:error,
                "The field must be the next type: :atom, :string, :list, :map, :tuple, :number, :boolean, :integer, :float."}
    end

    test "Between rule wrong." do
      data = %{
        "id" => 12_345,
        "name" => "Vegeta"
      }

      schema = [
        name: [between: {"2", "16"}]
      ]

      result = validate(data, schema)

      assert result == {:error, "The 'between' rule is wrong."}
    end

    test "Between value invalid." do
      data = %{
        "id" => 12_345,
        "name" => :vegeta
      }

      schema = [
        name: [between: {2, 16}]
      ]

      result = validate(data, schema)

      assert result == {:error, "Between value has to be :string, :tuple, :numeric, :list."}
    end

    test "Value not between message." do
      data = %{
        "id" => 12_345,
        "name" => "Krilin"
      }

      schema = [
        name: [between: {10, 16}]
      ]

      result = validate(data, schema)

      assert result == {:error, "The field 'name' is not between '{10, 16}'."}
    end

    test "Not nullable message." do
      data = %{
        "id" => 12_345,
        "name" => "Krilin"
      }

      schema = [
        name: [:nullable]
      ]

      result = validate(data, schema)

      assert result == {:error, "The 'name' is not nullable."}      
    end
  end
end
