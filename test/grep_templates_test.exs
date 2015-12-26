ExUnit.start

defmodule GrepTemplatesTest do
   use ExUnit.Case

   import ExUnit.CaptureIO
   import GrepTemplates, only: [ main: 1 ]

   test "--help returns help output ignoring other parameters" do
      fun = fn -> main(["test/mltest_a.xml", "test/thisfiledoesnotexist", "--help"]) end
      expected = "usage: grep_templates.exs [--help] [file...]\n"
      actual   = capture_io(:stdio, fun)
      assert actual == expected
   end

   test "returns errors about all nonexisting options" do
      fun = fn -> main(["test/mltest_a.xml", "test/thisfiledoesnotexist", "-xy", "-z", "--what"]) end
      expected = """
      grep_templates.exs: Unknown option 'xy'
      grep_templates.exs: Unknown option 'z'
      grep_templates.exs: Unknown option '-what'
      Type 'grep_templates.exs --help' for more information.
      """
      actual   = capture_io(:stderr, fun)
      assert actual == expected
   end

   test "scan files mltest_a.xml and mltest_b.xml" do
      fun = fn -> main(["test/mltest_a.xml", "test/mltest_b.xml"]) end
      expected1 = File.read! "test/mltest_a.out" 
      expected2 = File.read! "test/mltest_b.out"
      expected = expected1 <> expected2
      actual   = capture_io(:stdio, fun)
      assert actual == expected
   end

   test "zero arguments, search in stdin" do
      fun = fn -> main([]) end
      input = """
      aaa <Templates> bbb
      ccc </Templates> ddd
      """
      expected = "<Templates> bbb\nccc </Templates>\n"
      actual   = capture_io(:stdio, input, fun)
      assert actual == expected
   end

   test "search in files and stdin" do
      fun = fn -> main(["test/mltest_a.xml", "-", "test/mltest_b.xml"]) end
      input = """
      eee <Templates> fff
      ggg </Templates> hhh
      """
      expected1 = File.read! "test/mltest_a.out" 
      expected2 = File.read! "test/mltest_b.out"
      expected = expected1 <> "<Templates> fff\nggg </Templates>\n" <> expected2
      actual   = capture_io(:stdio, input, fun)
      assert actual == expected
   end

end
