defmodule Exvalidate.Rules.TypeTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Type

  describe "Type is an atom." do
    test "Atom validation pass." do
      rules = %{"type" => :atom}
      data = %{"type_character" => :Saiyajin}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_character" => :Saiyajin}}
    end

    test "Atom validation get wrong." do
      rules = %{"type" => :atom}
      data = %{"type_character" => 33}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_character must be type atom."}
    end

    test "String validation pass." do
      rules = %{"type" => :atom}
      data = %{"type_character" => "Saiyajin"}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_character" => :Saiyajin}}
    end
  end

  describe "Type is a string." do
    test "String validation pass." do
      rules = %{"type" => :string}
      data = %{"type_character" => "Saiyajin"}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_character" => "Saiyajin"}}
    end

    test "String validation get wrong." do
      rules = %{"type" => :string}
      data = %{"type_character" => 33}
      field = "type_character"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_character must be type string."}
    end
  end

  describe "Type is a list." do
    test "List validation pass." do
      rules = %{"type" => :list}
      data = %{"type_characters" => ["Saiyajin", "Namek"]}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_characters" => ["Saiyajin", "Namek"]}}
    end

    test "List validation get wrong." do
      rules = %{"type" => :list}
      data = %{"type_characters" => "Saiyajin"}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_characters must be type list."}
    end
  end

  describe "Type is a map." do
    test "Map validation pass." do
      rules = %{"type" => :map}
      data = %{"type_characters" => %{"Saiyajin" => "Vegetta"}}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_characters" => %{"Saiyajin" => "Vegetta"}}}
    end

    test "Map validation get wrong." do
      rules = %{"type" => :map}
      data = %{"type_characters" => "Saiyajin"}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_characters must be type map."}
    end
  end

  describe "Type is a tuple." do
    test "Tuple validation pass." do
      rules = %{"type" => :tuple}
      data = %{"type_characters" => {"Saiyajin", "Namek"}}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"type_characters" => {"Saiyajin", "Namek"}}}
    end

    test "Tuple validation get wrong." do
      rules = %{"type" => :tuple}
      data = %{"type_characters" => "Saiyajin"}
      field = "type_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "type_characters must be type tuple."}
    end
  end
end
