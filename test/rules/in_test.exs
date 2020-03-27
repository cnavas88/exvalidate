defmodule Exvalidate.Rules.InTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.In

  describe "validating/3 in is not a list" do
    test "is a number" do
      rules = {:in, 6}
      value = "Vegeta"

      result = In.validating(rules, value)

      assert result == {:error, :in_rule_wrong}
    end
  end

  describe "validating/3 value as a string or number." do
    test "value is string and is into the list." do
      rules = {:in, ["Vegeta", "Kakarot"]}
      value = "Vegeta"

      result = In.validating(rules, value)

      assert result == {:ok, "Vegeta"}
    end

    test "Value is string and is not into the list." do
      rules = {:in, ["Vegeta", "Kakarot"]}
      value = "Boo"

      result = In.validating(rules, value)

      assert result == {:error, :in_not_in_list}
    end

    test "Value is a number and is into the list." do
      rules = {:in, [1, 10.1]}
      value = 10.1

      result = In.validating(rules, value)

      assert result == {:ok, 10.1}
    end

    test "Value is a number and is not into the list." do
      rules = {:in, [1, 10]}
      value = 5

      result = In.validating(rules, value)

      assert result == {:error, :in_not_in_list}
    end

    test "Value is not a number, string or list" do
      rules = {:in, ["Vegeta", "Kakarot"]}
      value = {:boo, :vegeta}

      result = In.validating(rules, value)

      assert result == {:error, :in_bad_type_value}
    end
  end

  describe "validating/3 value as a list." do
    test "values is into the list." do
      rules = {:in, ["Vegeta", "Kakarot", "Picolo", "Boo"]}
      value = ["Vegeta", "Boo"]

      result = In.validating(rules, value)

      assert result == {:ok,["Vegeta", "Boo"]}
    end

    test "values isn't into the list." do
      rules = {:in, ["Vegeta", "Kakarot", "Picolo", "Boo"]}
      value =["Vegeta", "Lufi", "Boo"]

      result = In.validating(rules, value)

      assert result == {:error, :in_not_in_list}
    end
  end
end
