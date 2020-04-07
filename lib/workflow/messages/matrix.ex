defmodule Exvalidate.Messages.Matrix do
  @moduledoc """
  Matrix contains the all messages for errors.
  """

  @matrix %{
    :required_rule_wrong => "The 'rule' required is wrong.",
    :required_value_wrong => "The field '%FIELD%' is required.",
    :in_not_in_list => "'%FIELD%' hasn't into the list '%RULE_OPTS%'.",
    :in_rule_wrong => "The rule 'in' is wrong.",
    :in_bad_type_value => "The field '%FIELD%' has to be a String, number or list.",
    :length_not_equal => "'%FIELD%' length must be equal than '%RULE_OPTS%'",
    :length_rule_wrong => "The rule 'length' is wrong.",
    :length_value_type_wrong => "The field '%FIELD%' has to be a String or list.",
    :default_rule_wrong => "",
    :max_length_greater_than_max => "",
    :max_length_rule_wrong => "",
    :max_length_value_type_wrong => "",
    :min_length_lower_than_min => "",
    :min_length_rule_wrong => "",
    :min_length_value_type_wrong => "",
    :type_value_wrong => "",
    :type_rule_wrong => "",
    :type_value_is_not_supported => "",
    :email_invalid => "",
    :email_rule_wrong => "",
    :rule_doesnt_exists => "",
    :accepted_rule_wrong => "",
    :not_accepted => "",
    :between_rule_wrong => "",
    :between_value_invalid => "",
    :not_between_min_max => ""
  }

  def get_message(a_message), do: Map.get(@matrix, a_message)
end
