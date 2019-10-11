defmodule Exvalidate.Rules.Required do
  @moduledoc """
  Required rule comproves that the parameter "field" exists in the map "data".
  And check the content, if the content is nil or empty string the rule
  required won't pass.

  For see the example go to the tests: test/rules/required_test.exs
  """

  @spec validating(map, String.t(), map) :: {:ok, map} | {:error, String.t()}

  def validating(%{"required" => true}, field, data) do
    if conditions(field, data) do
      {:ok, data}
    else
      {:error, "#{field} is required."}
    end
  end

  def validating(%{"required" => false}, _field, data) do
    {:ok, data}
  end

  def validating(_, _, _), do: {:error, "Rule required is wrong."}

  @spec conditions(String.t(), map) :: boolean

  defp conditions(field, data) do
    Map.has_key?(data, field) &&
      data[field] != nil &&
      data[field] != ""
  end
end
