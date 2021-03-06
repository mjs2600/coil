defmodule Mix.Tasks.Coil do
  use Mix.Task

  def run(args) do
    case Enum.first(args) do
      nil -> IO.puts "You must specify a valid path"
      path ->
        if [:ok, {:error, :eexist}] |> Enum.member?(File.mkdir(path)) do
          copy_example(path)

          IO.puts """

Blog structure created!

  Run 'cd #{path}; mix deps.get' to fetch dependencies
  Then you can simply run 'PORT=8080 mix run --no-halt' to start the server
"""
        else
          IO.puts "You must specify a valid path"
        end
    end
  end

  defp copy_example(path) do
    File.cp_r("example", path)

    File.cp_r("deps", Path.join(path, "deps"))
    File.cp_r("_build", Path.join(path, "_build"))
    File.cp("mix.lock", path)
  end
end
