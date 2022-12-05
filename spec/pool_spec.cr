require "./spec_helper"

describe DB::Pool do
  it "should write from multiple connections" do
    channel = Channel(Nil).new
    fibers = 5
    max_n = 50
    with_db  do |db|
      db.exec "BEGIN EXECUTE IMMEDIATE 'drop table numbers'; EXCEPTION WHEN OTHERS THEN NULL; END;"
      db.exec "create table numbers (n number, fiber number)"

      fibers.times do |f|
        spawn do
          (1..max_n).each do |n|
            db.exec "insert into numbers (n, fiber) values (:1, :2)", n, f
            sleep 0.01
          end
          channel.send nil
        end
      end

      fibers.times { channel.receive }

      # all numbers were inserted
      s = fibers * max_n * (max_n + 1) // 2
      db.scalar("select sum(n) from numbers").should eq(s)
    end
  end
end