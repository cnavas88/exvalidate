defmodule Exvalidate.Rules.TypeTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Type

  describe "Type is atom." do
    test "Atom and validation pass." do
      rules = %{"type" => :atom}
      data = %{"type_character" => :sayan}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_character" => :sayan}}
    end

    test "Atom and validation get wrong." do
      rules = %{"type" => :atom}
      data = %{"type_character" => 33}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_character must be type atom."}
    end

    test "String and validation pass." do
      rules = %{"type" => :atom}
      data = %{"type_character" => "sayan"}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_character" => :sayan}}
    end
  end
end
