defmodule Exvalidate.Rules.DefaultTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Default

  describe "validating/3." do
    test "without default value in map." do
      rules = %{"default" => "Son goku"}
      data = %{}
      field = "name"

      result = Default.validating(rules, field, data)

      assert result == {:ok, %{"name" => "Son goku"}}
    end

    test "With value in map." do
      rules = %{"default" => "Son goku"}
      data = %{"name" => "Son gohan"}
      field = "name"

      result = Default.validating(rules, field, data)

      assert result == {:ok, data}
    end
  end
end
