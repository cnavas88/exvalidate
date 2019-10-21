defmodule Exvalidate.ValidateTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Validate

  # Integration test

  test "Validate String and return ok" do
    field = "name"

    rules = %{
      "required" => true,
      "max_length" => 10,
      "min_length" => 3
    }

    data = %{"name" => "Carlos"}
    result = Validate.rules(field, rules, data)

    assert result == {:ok, %{"name" => "Carlos"}}
  end

  test "Validate but the rule doesn't exists" do
    field = "name"

    rules = %{
      "required" => true,
      "satan_city" => 10,
      "min_length" => 3
    }

    data = %{"name" => "Carlos"}
    result = Validate.rules(field, rules, data)

    assert result == {:error, "The rule 'satan_city' doesn't exists."}
  end

  test "Validate is wrong" do
    field = "name"

    rules = %{
      "required" => true,
      "max_length" => 4,
      "min_length" => 1
    }

    data = %{"name" => "Carlos"}
    result = Validate.rules(field, rules, data)

    assert result == {:error, "name must be lower than or equal to 4."}
  end
end
