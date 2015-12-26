# GrepTemplates

Elixir demo project demonstrating:
- Command line interface using OptionParser
- Multiline search in files. Prints everything between <Template> and </Templates> markers
- Mix custom task running in compilation phase

## Installation

  1. Install Elixir

        Follow the instructions on http://elixir-lang.org/install.html

  2. Clone project:

         git clone https://github.com/nico-amsterdam/elixir-multiline-search-demo.git

  3. Compile & unit test:

         cd elixir-multiline-search-demo
         mix test

        A script directory will be created. Modules in the lib directory will be converted to scripts in the script directory. Assumed is that the modules all contain a main function.
        
  4. Run the script:
  
         chmod +x script/grep_templates.exs
         script/grep_templates.exs --help
        
        script/grep_templates.exs test/mltest_{a,b}.xml
        

