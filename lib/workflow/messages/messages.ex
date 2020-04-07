defmodule Exvalidate.Messages do
  @moduledoc """
  Module for get the string message
  """

  alias Exvalidate.Messages.Matrix

  def get({{rule, rule_opts}, error}, data, field) do
    error
    |> Matrix.get_message()
    |> String.replace("%FIELD%", "#{field}")
    |> String.replace("%RULE_OPTS%", "#{inspect rule_opts}")
  end
  def get({rule, error}, data, field) do
    error
    |> Matrix.get_message()
    |> String.replace("%FIELD%", "#{field}")
  end
end