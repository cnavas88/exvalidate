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

  describe "Type is a boolean." do
    test "Boolean true validation pass." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => true}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => true}}
    end

    test "Boolean false validation pass." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => false}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => false}}
    end

    test "String 'true' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "true"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => true}}
    end

    test "String 'false' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "false"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => false}}
    end

    test "String 'TRUE' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "TRUE"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => true}}
    end

    test "String 'FALSE' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "FALSE"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => false}}
    end

    test "String '1' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "1"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => true}}
    end

    test "String '0' validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "0"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => false}}
    end

    test "Other String validation wrong." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => "kakarot"}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:error, "is_saiyajin must be type boolean."}
    end

    test "Number 1 validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => 1}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => true}}
    end

    test "Number 0 validation pass and convert." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => 0}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"is_saiyajin" => false}}
    end

    test "Boolean validation get wrong." do
      rules = %{"type" => :boolean}
      data = %{"is_saiyajin" => %{}}
      field = "is_saiyajin"

      result = Type.validating(rules, field, data)

      assert result == {:error, "is_saiyajin must be type boolean."}
    end
  end

  describe "Type is a :integer." do
    test "Integer validation pass." do
      rules = %{"type" => :integer}
      data = %{"num_characters" => 3}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3}}
    end

    test "Integer validation get wrong." do
      rules = %{"type" => :integer}
      data = %{"num_characters" => [3]}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type integer."}
    end

    test "String validation pass." do
      rules = %{"type" => :integer}
      data = %{"num_characters" => "3"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3}}
    end

    test "String validation get wrong." do
      rules = %{"type" => :integer}
      data = %{"num_characters" => "Three"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type integer."}
    end
  end

  describe "Type is a :float." do
    test "Float validation pass." do
      rules = %{"type" => :float}
      data = %{"num_characters" => 3.5}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3.5}}
    end

    test "Float validation get wrong." do
      rules = %{"type" => :float}
      data = %{"num_characters" => [3]}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type float."}
    end

    test "String validation pass." do
      rules = %{"type" => :float}
      data = %{"num_characters" => "3.3"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3.3}}
    end

    test "String validation get wrong." do
      rules = %{"type" => :float}
      data = %{"num_characters" => "Three"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type float."}
    end
  end

  describe "Type is a :number." do
    test "Float validation pass." do
      rules = %{"type" => :float}
      data = %{"num_characters" => 3.5}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3.5}}
    end

    test "Float validation get wrong." do
      rules = %{"type" => :float}
      data = %{"num_characters" => [3]}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type float."}
    end

    test "String validation pass." do
      rules = %{"type" => :float}
      data = %{"num_characters" => "3.3"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:ok, %{"num_characters" => 3.3}}
    end

    test "String validation get wrong." do
      rules = %{"type" => :float}
      data = %{"num_characters" => "Three"}
      field = "num_characters"

      result = Type.validating(rules, field, data)

      assert result == {:error, "num_characters must be type float."}
    end
  end
end
