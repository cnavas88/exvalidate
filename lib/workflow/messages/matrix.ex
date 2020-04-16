defmodule Exvalidate.Messages.Matrix do
  @moduledoc """
  Matrix contains the all messages for errors.
  """

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
    :max_length_greater_than_max => "'%FIELD%' field must be lower than or equal to '%RULE_OPTS%'.",
    :max_length_rule_wrong => "The rule 'max_length' is wrong.",
    :max_length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :min_length_lower_than_min => "'%FIELD%' field must be greater than or equal to '%RULE_OPTS%'.",
    :min_length_rule_wrong => "The rule 'min_length' is wrong.",
    :min_length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :type_value_wrong => "",
    :type_rule_wrong => "",
    :type_value_is_not_supported => "",
    :email_invalid => "'%DATA%' is not an email.",
    :email_rule_wrong => "Email rule wrong, type '%FIELD%' is not a string.",
    :rule_doesnt_exists => "",
    :accepted_rule_wrong => "",
    :not_accepted => "",
    :between_rule_wrong => "",
    :between_value_invalid => "",
    :not_between_min_max => ""
  }

  def get_message(a_message), do: Map.get(@matrix, a_message)
end
