defmodule Exvalidate.Rules.RequiredTest do
  use ExUnit.Case
  doctest Exvalidate

  alias Exvalidate.Rules.Required

  describe "validating/3." do
    test "Required with FALSE value." do
      rules = %{"required" => false}
      data  = %{"id" => 1234}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:ok, data}
    end

    test "Required with TRUE value and good field." do
      rules = %{"required" => true}
      data  = %{"id" => 1234}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:ok, data}
    end

    test "Required with TRUE value and field id nil." do
      rules = %{"required" => true}
      data  = %{"id" => nil}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:error, "id is required."}
    end

    test "Required with TRUE value and field id empty string." do
      rules = %{"required" => true}
      data  = %{"id" => ""}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:error, "id is required."}
    end

    test "Required with TRUE value and field id doesnt exists." do
      rules = %{"required" => true}
      data  = %{"name" => "Son goku"}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:error, "id is required."}
    end

    test "Required with a wrong value." do
      rules = %{"required" => "yes"}
      data  = %{"name" => "Son goku"}
      field = "id"

      result = Required.validating(rules, field, data)

      assert result == {:error, "Rule required is wrong."}
    end
  end
end
