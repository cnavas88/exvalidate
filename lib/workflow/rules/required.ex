defmodule Exvalidate.Rules.Required do
  @moduledoc false

  def validate(%{required: true}, field, params) do
    if conditions(field, params) do
      {:ok, params}
    else
      {:error, "#{field} is required"}
    end
  end

  def validate(%{required: false}, field, params) do
    {:ok, params}
  end

  defp conditions(field, params) do
    Map.has_key?(params, field) &&
    params[field] != nil        &&
    params[field] != ""
  end
end
