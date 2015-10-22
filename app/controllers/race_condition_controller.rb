# Race condition controller
class RaceConditionController < ApplicationController
  @counter = 0

  class << self
    attr_accessor :counter
  end

  trap(:INFO) do
    $stderr.puts "Count: #{RaceConditionController.counter}"
  end

  def index
    @counter = self.class.counter # Read
    sleep(0.1)
    @counter += 1                 # Update
    sleep(0.1)
    self.class.counter = @counter # Write

    respond_to do |format|
      format.html do
        render plain: "Counter: #{@counter}", locals: { counter: @counter }
      end
    end
  end
end
