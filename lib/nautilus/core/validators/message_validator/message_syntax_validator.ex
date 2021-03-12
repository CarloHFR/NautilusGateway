defmodule Nautilus.Core.Validators.MessageValidator.MessageSyntaxValidator do

    def validate_message_syntax(message) do
        case Map.has_key?(message, "version") do
            :true ->
                version = message["version"]

                case get_header_fields(version) do
                    {:ok, fields} ->
                        case validate_fields(fields, message) do
                            {:valid, _} ->
                                {:valid, message}
                            _ ->
                                {:invalid, message}
                        end
                    _ ->
                        {:invalid, message}
                end
            _ ->
                {:invalid, message}
        end
    end


    defp get_header_fields("1.0"), do: {:ok, ["version", "to", "from", "action", "type", "body-size", "content"]}
    defp get_header_fields(_), do: {:error, :wrong_version}


    defp validate_fields([], _message), do: {:valid, :valid}
    defp validate_fields([head|tail], message) do
        case Map.has_key?(message, head) do
            :true ->
                validate_fields(tail, message)
            _ ->
                {:invalid, :non_right_fields}
        end
    end

end