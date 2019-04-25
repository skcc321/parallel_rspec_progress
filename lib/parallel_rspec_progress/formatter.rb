require "parallel_tests"
require "drb/drb"

class ParallelProgressFormatter
  RSpec::Core::Formatters.register self,
    :start,
    :example_passed,
    :example_failed,
    :example_pending,
    :close

  attr_reader :controller

  def initialize(output)
    @output = output
    @controller = DRbObject.new_with_uri('druby://localhost:9999')
  end

  def start(notification)
    controller.put_total(notification.count)
  end

  def close(notification)
    if ParallelTests.last_process?
      ParallelTests.wait_for_other_processes_to_finish

      controller.stop
    end
  end

  def example_passed(notification)
    controller.add(key: :passed, item: 1)
  end

  def example_failed(notification)
    controller.add(key: :failed, item: 1)
  end

  def example_pending(notification)
    controller.add(key: :pending, item: 1)
  end
end
