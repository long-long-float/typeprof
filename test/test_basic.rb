require "test/unit"
require_relative "../lib/typeprof"

module TypeProf
  class BasicTest < Test::Unit::TestCase
    def test_class
      serv = TypeProf::Service.new

      serv.update_file("test0.rb", <<-END)
class C
  def initialize(n)
    n
  end

  def foo(n)
    C
  end
end
C.new(1).foo("str")
      END

      assert_equal(
        ["def initialize: (Integer) -> Integer"],
        serv.get_method_sig([:C], false, :initialize),
      )
      assert_equal(
        ["def foo: (String) -> singleton(C)"],
        serv.get_method_sig([:C], false, :initialize),
      )
    end
  end
end
