defmodule Exvalidate.Rules.Required do
  @moduledoc false

  def validating(%{"required" => true}, field, data) do
    if conditions(field, data) do
      {:ok, data}
    else
      {:error, "#{field} is required"}
    end
  end

  def validating(%{"required" => false}, field, data) do
    {:ok, data}
  end

  defp conditions(field, data) do
    Map.has_key?(data, field) &&
    data[field] != nil        &&
    data[field] != ""
  end
end
