defmodule Exvalidate.Rules.Required do
  @moduledoc false

  # @spec validating(map, String.t, map) :: {:ok, map} || {:error, String.t}

  def validating(%{"required" => true}, field, data) do
    if conditions(field, data) do
      {:ok, data}
    else
      {:error, "#{field} is required."}
    end
  end
  def validating(%{"required" => false}, field, data) do
    {:ok, data}
  end
  def validating(_, _, _), do: {:error, "Rule required is wrong."}

  @spec conditions(String.t, map) :: boolean

  defp conditions(field, data) do
    Map.has_key?(data, field) &&
    data[field] != nil        &&
    data[field] != ""
  end
end
