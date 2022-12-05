# crystal-odpi

Crystal ODPI driver implements [crystal-db](https://github.com/crystal-lang/crystal-db) API and is a wrapper around [ODPI-C](https://github.com/oracle/odpi).

Oracle Database Programming Interface for C (ODPI-C) is an open source library of C code that simplifies access to Oracle Database for applications written in C or C++.

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     odpi:
       github: silkPK/crystal-odpi
   ```

2. Run `shards install`

## Usage

```crystal
require "db"
require "odpi"

DB.open "odpi://user:password@host:port/SID" do |db|
  db.exec "BEGIN EXECUTE IMMEDIATE 'drop table person'; EXCEPTION WHEN OTHERS THEN NULL; END;"
  db.exec "create table person (name varchar(30), age int)"
  db.exec "insert into person values (:1, :2)", "Ben Buddy", 28

  puts "max age:"
  puts db.scalar "select max(age) from contacts" # => 33

  puts "person:"
  db.query "select name, age from person order by age desc" do |res|
    puts "#{res.column_name(0)} (#{res.column_name(1)})"
    # => name (age)
    res.each do
      puts "#{res.read} (#{res.read})"
    end
  end
end
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/sourgrasses/crystal-odpi/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [silkPK](https://github.com/your-github-user) - creator and maintainer
