defmodule Ini.ExampleTest do
  use ExUnit.Case

  test "parses into struct" do
    contents = """
    [database]
    host = 192.168.1.42
    user = postgres
    ; port = 1234
    [log]
    level = debug
    ; file = application.log
    """

    assert %{
             database: database,
             log: log
           } = Ini.decode(contents)

    assert %{host: "192.168.1.42", port: 1234, user: "postgres"} =
             struct!(DatabaseSettings, database)

    assert %{level: "debug", file: "application.log"} = struct!(LogSettings, log)
  end
end

defmodule DatabaseSettings do
  defstruct host: "", port: 1234, user: ""
end

defmodule LogSettings do
  defstruct level: "", file: "application.log"
end
