# Pool implements a worker pool of fibers.
# Example
# ```
# SIZE = 4
#
# pool = Pool.new(SIZE)
#
# (1..SIZE).each do |i|
#   pool.spawn do
#     puts "Job started, this will take a #{i} seconds..."
#     sleep i.second
#     puts "Job done #{i} done."
#   end
# end
#
# pool.wait
# ```
module Pool
  VERSION = "0.1.0"

  # Pool allows you to run a series of jobs on a set amount of fibers.
  class Pool
    # create a new pool and spawn `size` workers that await jobs.
    def initialize(@size : Int32)
      @jobs = Channel(Proc(Nil)).new
      @done = Channel(Nil).new

      # spawn the workers, they will wait for a job
      # on the jobs channel then execute it.
      (1..@size).each do
        ::spawn do
          while job = @jobs.receive?
            job.call
          end
          @done.send nil
        end
      end
    end

    # spawn a worker in the pool, returns once the worker
    # has started executing.
    def spawn(&block)
      @jobs.send block
    end

    # wait for all workers to finish, can only be called once.
    def wait
      @jobs.close
      (1..@size).each do
        @done.receive
      end
      @done.close
    end
  end

  # shortcut for Pool::Pool.new(size)
  def self.new(size : Int32)
    Pool.new(size)
  end
end
