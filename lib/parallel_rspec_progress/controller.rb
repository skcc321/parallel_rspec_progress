require "ruby-progressbar"
require "drb/drb"
require "rainbow"

module ParallelRspecProgress
  class Controller
    def initialize
      @failed = []
      @passed = []
      @pending = []
      @total = 0
    end

    def stop
      DRb.stop_service
      process_results
    end

    def put_total(val)
      if @progressbar
        @total += val
        @progressbar.total = @total
      else
        @total = val
        create_progressbar
      end
    end

    def add(key:, item:)
      case key
      when :failed
        @failed << item
      when :passed
        @passed << item
      when :pending
        @pending << item
      end

      @progressbar.title = compose_title
      @progressbar.increment
    end

    private

      def create_progressbar
        @progressbar = ProgressBar.create(
          format: "%a %e %P% Processed: %c from %C %b\u{15E7}%i %p%% %t",
          progress_mark: ' ',
          remainder_mark: "\u{FF65}",
          starting_at: 0,
          total: @total
        )
      end

      def compose_title
        "passed: #{Rainbow(@passed.count).green}  failed: #{Rainbow(@failed.count).red}  pending: #{Rainbow(@pending.count).yellow}"
      end

      def process_results
        if @failed.any?
          puts @failed.map {|x| "#{Rainbow(x).red}" }
        else
          puts Rainbow("Everything is OK!").green
        end
      end
  end
end
