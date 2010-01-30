require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "DefineColumns" do

  before(:each) do
    @original_content_cols = [ mock_active_record("house"), mock_active_record("car"), mock_active_record("room"), mock_active_record("television") ]
    MockModel.stubs(:content_columns).returns(@original_content_cols)
  end

  def mock_active_record(name)
    mock_active_record = mock()
    mock_active_record.stubs(:name).returns(name)
    mock_active_record
  end

  it "should hide the defined content columns" do
    MockModel.class_eval do
      define_columns do |columns|
        columns.hide %w(house)
      end
    end

    MockModel.table_columns.map(&:name).include?("house").should == false
  end

  it "should add the defined content columns" do
    MockModel.class_eval do
      define_columns do |columns|
        columns.add %w(lamp)
      end
    end

    MockModel.table_columns.map(&:name).include?("lamp").should == true
  end

  it "should customize the output of the defined content columns" do
    MockModel.class_eval do
      def road
        %\Robinson Road\
      end

      define_columns do |columns|
        columns.add %w(road)
        columns.show(:road) do |road|
          %\-#{road}-\
        end
      end
    end

    MockModel.table_columns.each do |col|
      if col.name.eql?("road")
        col.show(MockModel.new).should == %\-Robinson Road-\
      end
    end
  end

  it "should show the column name in a humanized manner" do
    MockModel.class_eval do
      def traffic_jam
        %\Traffic Jam\
      end

      define_columns do |columns|
        columns.add %w(traffic_jam)
      end
    end

    MockModel.table_columns.each do |col|
      if col.name.eql?("traffic_jam")
        col.header.should == %\Traffic jam\
      end
    end
  end

end
