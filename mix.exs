defmodule GrepTemplates.Mixfile do
  use Mix.Project

  def project do
    [app: :grep_templates,
     version: "0.0.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     compilers: [:yecc, :leex, :erlang, :elixir, :app, :script_it],
     escript: [main_module: GrepTemplates],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end
end

defmodule Mix.Tasks.Compile.ScriptIt do
  use Mix.Task

   @shortdoc "Copy .ex files to script subdirectory. Rename to .exs and append a line to call the main method."
   @moduledoc @shortdoc

   def run(_) do
      # create directory to store scripts
      unless File.dir?("script"), do: File.mkdir! "script"

      # lookup source path
      project_config = Mix.Project.config
      source_paths = project_config[:elixirc_paths]

      # find modules and change them into script files
      Mix.Utils.extract_files(source_paths, "*.ex")
      |> Enum.map(&(script_it(&1)))
   end

   defp script_it(filename) do
     basename = Path.basename(filename, ".ex")
     scriptfilename = "script/" <> basename <> ".exs"
     File.copy!(filename, scriptfilename)
     file = File.open!(scriptfilename, [:append])
     modulename = Mix.Utils.camelize basename
     IO.puts(file, "\n" <> modulename <> ".main(System.argv())")
     File.close(file)
   end
end
