# GrepTemplates

Elixir demo project demonstrating:
- Command line interface using OptionParser
- Multiline search in files. Prints everything between &lt;Template&gt; and &lt;/Templates&gt; markers
- Mix custom task running in compilation phase

## Installation

### Install Elixir

Follow the instructions on http://elixir-lang.org/install.html

### Clone project

```sh
$ git clone https://github.com/nico-amsterdam/elixir-multiline-search-demo.git
```

### Compile & unit test

```sh
$ cd elixir-multiline-search-demo
$ mix test
```

A script directory will be created.
Modules in the lib directory will be converted to scripts in the script directory.
Assumed is that the modules all contain a main function.
The file 'mix.exs' contains the task to create the scripts during the compilation phase.
        
### Run the script
  
```sh
$ chmod +x script/grep_templates.exs
$ script/grep_templates.exs --help
$ script/grep_templates.exs test/mltest_{a,b}.xml
```

