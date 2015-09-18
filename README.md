Ini
===
Add to your mix.exs
```
defp deps do
  [
    {:ini, git: "https://github.com/nathanjohnson320/ini.git"}
  ]
end
```

Use in another module
```
{:ok, ini} = File.read "./test.ini"
ini = Ini.decode(ini)
```
