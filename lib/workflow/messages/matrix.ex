defmodule Exvalidate.Messages.Matrix do
  @moduledoc false

  @matrix %{
    :required_rule_wrong => "The rule 'required' is wrong.",
    :required_value_wrong => "The field '%FIELD%' is required.",
    :in_not_in_list => "'%FIELD%' hasn't into the list '%RULE_OPTS%'.",
    :in_rule_wrong => "The rule 'in' is wrong.",
    :in_bad_type_value => "The field '%FIELD%' has to be a String, number or list.",
    :length_not_equal => "'%FIELD%' length must be equal than '%RULE_OPTS%'",
    :length_rule_wrong => "The rule 'length' is wrong.",
    :length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :default_rule_wrong => "The rule 'default' is wrong.",
    :max_length_greater_than_max =>
      "'%FIELD%' field must be lower than or equal to '%RULE_OPTS%'.",
    :max_length_rule_wrong => "The rule 'max_length' is wrong.",
    :max_length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :min_length_lower_than_min =>
      "'%FIELD%' field must be greater than or equal to '%RULE_OPTS%'.",
    :min_length_rule_wrong => "The rule 'min_length' is wrong.",
    :min_length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :type_value_wrong => "'%FIELD%' must be type '%RULE_OPTS%'.",
    :type_rule_wrong => "The type rule must be an atom.",
    :type_value_is_not_supported =>
      "The field must be the next type: :atom, :string, :list, :map, :tuple, :number, :boolean, :integer, :float.",
    :email_invalid => "'%DATA%' is not an email.",
    :email_rule_wrong => "Email rule wrong, type '%FIELD%' is not a string.",
    :rule_doesnt_exists => "The rule '%RULE%' doesn't exists.",
    :not_accepted => "The field '%FIELD%' is not accepted.",
    :between_rule_wrong => "The 'between' rule is wrong.",
    :between_value_invalid => "Between value has to be :string, :tuple, :numeric, :list.",
    :not_between_min_max => "The field '%FIELD%' is not between '%RULE_OPTS%'."
  }

  @spec get_message(atom) :: String.t()

  @doc false
  def get_message(a_message), do: Map.get(@matrix, a_message)
end
