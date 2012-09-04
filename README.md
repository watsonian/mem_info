# mem_info

This is a lightweight library that wraps access to the data in /proc/meminfo found in many linux variants, which contains live memory usage information about a machine.

## Getting Started

Install the gem:

```ruby
gem install mem_info
```

Require the library like you would expect:

```ruby
require 'mem_info'
```

Then create a new MemInfo object:

```ruby
m = MemInfo.new
m.memtotal     => 70000
m.memfree      => 54300
m.memused      => 15700
m.free_buffers => 75000
```

Take a look in `lib/mem_info.rb` for all fields that are available.

## Copyright

Copyright (c) 2012 Joel Watson. See LICENSE for details.
