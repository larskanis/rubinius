require 'erb'
require File.expand_path('../../../../spec_helper', __FILE__)

describe 'ERB::DefMethod.def_erb_method' do


  input = <<'END'
<% for item in @items %>
<b><%= item %></b>
<% end %>
END


  it "define method to render eRuby file as an instance method of current module" do
    expected = <<'END'

<b>10</b>

<b>20</b>

<b>30</b>

END
    #
    begin
      File.open('_example.rhtml', 'w') {|f| f.write(input) }
      class MyClass3ForEruby
        extend ERB::DefMethod
        def_erb_method('render()', '_example.rhtml')
        def initialize(items)
          @items = items
        end
      end
      MyClass3ForEruby.new([10,20,30]).render().should == expected
    ensure
      File.unlink('_example.rhtml')
    end

  end


  it "define method to render eRuby object as an instance method of current module" do
    expected = <<'END'
<b>10</b>
<b>20</b>
<b>30</b>
END
    #
    MY_INPUT4_FOR_ERB = input
    class MyClass4ForErb
      extend ERB::DefMethod
      erb = ERB.new(MY_INPUT4_FOR_ERB, nil, '<>')
      def_erb_method('render()', erb)
      def initialize(items)
        @items = items
      end
    end
    MyClass4ForErb.new([10,20,30]).render().should == expected
  end


end
