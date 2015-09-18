defmodule IniTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "file with only comments is empty" do
    {:ok, ini} = File.read "./test/files/comments.ini"
    decoded = Ini.decode ini
    assert decoded == %{}
  end

  test "generic file is key value pairs" do
    {:ok, ini} = File.read "./test/files/generic.ini"
    decoded = Ini.decode ini
    assert decoded == %{anotherkey: "value", test: "1", yetanother: "another"}
  end

  test "nested maps from ini headers" do
    {:ok, ini} = File.read "./test/files/header.ini"
    decoded = Ini.decode ini
    assert decoded == %{super_admin_test_header: %{another: "test", host: "http://www.google.com", pass: "test", user: "test"}}
  end

  test "test arrays" do
    {:ok, ini} = File.read "./test/files/arrays.ini"
    decoded = Ini.decode ini
    assert decoded == %{ arrays_test: %{arr: ["test1", "test2", "test3", "test4"]}}
  end

  test "test full" do
    {:ok, ini} = File.read "./test/files/full.ini"
    decoded = Ini.decode ini
    assert decoded == %{body: %{h1: "test", h3: "testing"}, footer: %{js: ["script1.js", "script2.js", "script3.js"]}, header: %{css: ["style1.css", "style2.css"], meta: "tags", title: "test"}}
  end
end
