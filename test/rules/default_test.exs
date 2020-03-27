defmodule Exvalidate.Rules.DefaultTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Default

  describe "validating/3." do
    test "with value a nil." do
      rules = {:default, "Son goku"}
      value = nil

      result = Default.validating(rules, value)

      assert result == {:ok, "Son goku"}
    end

    test "with value a empty string." do
      rules = {:default, "Son goku"}
      value = ""

      result = Default.validating(rules, value)

      assert result == {:ok, "Son goku"}
    end

    test "With value." do
      rules = {:default, "Son goku"}
      value = "Son gohan"

      result = Default.validating(rules, value)

      assert result == {:ok, value}
    end

    test "Error passing first parameter to a default function" do
      rules = {:default}
      value = "Son gohan"

      result = Default.validating(rules, value)

      assert result == {:error, :default_rule_wrong}
    end
  end
end
