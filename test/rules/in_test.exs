defmodule Exvalidate.Rules.InTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.In

  describe "validating/3 in is not a string or list" do
    test "is a number" do
      rules = %{"in" => 6}
      data = %{"name" => "Vegeta"}
      field = "name"

      result = In.validating(rules, field, data)

      assert result == {:error, "The rule 'in' is wrong."}
    end
  end

  describe "validating/3 value as a string or number." do
    test "value is string and is into the list." do
      rules = %{"in" => ["Vegeta", "Kakarot"]}
      data = %{"name" => "Vegeta"}
      field = "name"

      result = In.validating(rules, field, data)

      assert result == {:ok, %{"name" => "Vegeta"}}
    end

    test "Value is string and is not into the list." do
      rules = %{"in" => ["Vegeta", "Kakarot"]}
      data = %{"name" => "Boo"}
      field = "name"

      result = In.validating(rules, field, data)

      assert result == {:error, "name hasn't into the list."}
    end

    test "Value is a number and is into the list." do
      rules = %{"in" => [1, 10]}
      data = %{"id" => 10}
      field = "id"

      result = In.validating(rules, field, data)

      assert result == {:ok, %{"id" => 10}}
    end

    test "Value is a num ber and is not into the list." do
      rules = %{"in" => [1, 10]}
      data = %{"id" => 5}
      field = "id"

      result = In.validating(rules, field, data)

      assert result == {:error, "id hasn't into the list."}
    end
  end

  describe "validating/3 value as a list." do
    test "values is into the list." do
      rules = %{"in" => ["Vegeta", "Kakarot", "Picolo", "Boo"]}
      data = %{"names" => ["Vegeta", "Boo"]}
      field = "names"

      result = In.validating(rules, field, data)

      assert result == {:ok, %{"names" => ["Vegeta", "Boo"]}}
    end

    test "values isn't into the list." do
      rules = %{"in" => ["Vegeta", "Kakarot", "Picolo", "Boo"]}
      data = %{"names" => ["Vegeta", "Lufi", "Boo"]}
      field = "names"

      result = In.validating(rules, field, data)

      assert result == {:error, "names hasn't into the list."}
    end
  end
end
