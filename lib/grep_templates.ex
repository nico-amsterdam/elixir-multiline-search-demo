#!/usr/bin/env elixir
#

defmodule GrepTemplates do

   @moduledoc """
   Demonstrate multiline search in file content.

   Prints everything between <Templates> and </Templates> markers.

   Runs as CLI utility.
   """

   @doc "Call main with file names. E.g. main([\"xmlfile.xml\"])"
   def main(args) do
      # OptionParser.parse returns { option_list, file_list, unknown_option_list } 
      parse = OptionParser.parse(args, strict: [help: :boolean])
      case parse do
         {[help: true] , _, _ }      -> show_help
         {_, [], [] }                -> scan ["-"]
         {_, file_name_list, [] }    -> scan file_name_list
         {_, _, failed_option_list } -> show_error failed_option_list
         _                           -> IO.puts(:stderr, "Error while parsing arguments.")
      end
   end

   # "print usage line"
   defp show_help, do: IO.puts "usage: grep_templates.exs [--help] [file...]"

   # "print last line of unknown options"
   defp show_error([]), do: IO.puts(:stderr, "Type 'grep_templates.exs --help' for more information.")

   # "print unknown options"
   defp show_error([option_value | tail]) do
      { option, _ } = option_value
      IO.puts(:stderr, "grep_templates.exs: Unknown option '" <> String.slice( option, 1..-1 ) <> "'")
      show_error tail
   end

   def scan([]), do: :ok

   def scan(["-" | tail]) do
      stdin_text = IO.read :all
      print_templates stdin_text
      scan tail 
   end

   @doc "search in given files for everything between <Templates> and </Templates> markers"
   def scan([filename | tail]) do
      file = File.read! filename
      print_templates file
      scan tail 
   end

   defp print_templates(text) do
      list_of_lists = Regex.scan(~r/<Templates>.*<\/Templates>/Us, text, capture: :all)
      IO.puts Enum.join(list_of_lists, "\n")
   end
end
