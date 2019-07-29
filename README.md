# pool

Simple fiber worker pool for crystal.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     pool:
       github: UlisseMini/pool
   ```

2. Run `shards install`

## Usage

```crystal
require "pool"

# create a pool of 4 workers
pool = Pool.new(4)

# spawn 10 tasks that each sleep for n seconds.
(1..10).each do |n|
  pool.spawn do
    puts "Job started, this will take a #{n} seconds..."
    sleep n.second
    puts "Job done #{n} done."
  end
end

# mark the pool as closed, any more calls to `spawn` will throw an error.
# then wait for all the workers to finish executing work and exit.
pool.wait
```

## Contributing

1. Fork it (<https://github.com/UlisseMini/pool/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Ulisse Mini](https://github.com/UlisseMini) - creator and maintainer
