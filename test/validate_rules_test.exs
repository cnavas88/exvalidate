defmodule Exvalidate.ValidateTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Validate

  # Integration test

  test "Validate String and return ok" do
    rules = [
      :required,
      max_length: 10,
      min_length: 3
    ]

    data = "Carlos"
    result = Validate.rules(rules, data)

    assert result == {:ok, "Carlos"}
  end

  test "Validate but the rule doesn't exists" do
    rules = [
      :required,
      satan_city: 10,
      min_length: 3
    ]

    data = "Carlos"
    result = Validate.rules(rules, data)

    assert result == {:error, {:satan_city, :rule_doesnt_exists}}
  end

  test "Validate is wrong" do
    rules = [
      :required,
      max_length: 4,
      min_length: 1
    ]

    data = "Carlos"
    result = Validate.rules(rules, data)

    assert result == {:error, {{:max_length, 4}, :max_length_greater_than_max}}
  end
end
