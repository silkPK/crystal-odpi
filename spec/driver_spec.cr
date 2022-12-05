require "./spec_helper"

describe Driver do
  it "should register odbc name" do
    DB.driver_class("odpi").should eq(ODPI::Driver)
  end
end