require "./spec_helper"

describe Connection do
  it "opens a connection without the pool" do
    with_cnn do |cnn|
      cnn.should be_a(ODPI::Connection)

      cnn.exec "BEGIN EXECUTE IMMEDIATE 'drop table person'; EXCEPTION WHEN OTHERS THEN NULL; END;"
      cnn.exec "create table person (name varchar(10), age number)"
      cnn.exec "insert into person (name,age) values ('Ben Buddy', 28)"

      cnn.scalar("select count(*) from person").should eq(1)
    end
  end
end