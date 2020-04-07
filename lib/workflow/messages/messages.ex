defmodule Exvalidate.Messages do
  @moduledoc """
  Module for get the string message
  """

  alias Exvalidate.Messages.Matrix

  def get({rule, error}, data, field) do
    error
    |> Matrix.get_message()
    |> String.replace("%FIELD%", Atom.to_string(field))
  end
end