defmodule Exvalidate.Messages.Matrix do
  @moduledoc """
  Matrix contains the all messages for errors.
  """

  @matrix %{
    :required_rule_wrong => "The rule required is wrong.",
    :required_value_wrong => "The value '%VALUE%' is required.",
    
    :in_not_in_list => "",
    :in_rule_wrong => "",
    :in_bad_type_value => "",

    :length_not_equal => "",
    :length_rule_wrong => "",
    :length_value_type_wrong => "",

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
    
    :rule_doesnt_exists => ""
  }

  def get_message(a_message, value) do
    message = Map.get(@matrix, a_message)
    String.replace(message, "'%VALUE%'", value)
  end 
end