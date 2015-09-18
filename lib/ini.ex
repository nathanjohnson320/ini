defmodule Ini do
  def decode(data) do
    # Filter out the garbage rows ; \n ""
    data = String.split(data, ~r/[\r\n]+/)
    |> Enum.filter fn line ->
      !Regex.match?(~r/^\s*[;]/, line) and line != ""
    end

    # Parse the remaining lines with that sick ini regex
    ini_regex = ~r/^\[([^\]]*)\]$|^([^=]+)(=(.*))?$/i
    data = Enum.map data, fn line ->
      hd(Regex.scan ini_regex, line)
    end

    # This mess parses the actual INI file
    output = Enum.reduce data, %{}, fn line, output ->
      case length(line) do
        x when x == 2 ->
          # This is a new field that isn't a list
          key = tl(line)
          |> hd
          |> String.to_atom

          {_, output} = get_and_update_in(output[:current], &{&1, &1 = key})
          {_, output} = get_and_update_in(output[key], &{&1, &1 = %{} })
        x when x > 3 ->
          # This is either a list or a regular value
          key = String.strip(Enum.at(line, 2))
          value = String.strip(Enum.at(line, 4))

          if String.slice(key, -2..-1) == "[]" do
            # Handle the case that we have a list
            key = String.slice(key, 0..-3)
            |> String.to_atom

            if !is_nil(output[output[:current]][key]) do
              {_, output} = get_and_update_in(output[output[:current]][key], &{&1, &1 ++ [value] })
            else
              {_, output} = get_and_update_in(output[output[:current]][key], &{&1, &1 = [value] })
            end
          else
            # This isn't an array it's just a normal key
            key = String.to_atom(key)

            # if there is no current we just pump out key value pairs
            if is_nil(output[:current]) do
              {_, output} = get_and_update_in(output[key], &{&1, &1 = value})
            else
              {_, output} = get_and_update_in(output[output[:current]][key], &{&1, &1 = value})
            end
          end
        _ ->
          output
      end
      output
    end
    Map.delete(output, :current)
  end
end
