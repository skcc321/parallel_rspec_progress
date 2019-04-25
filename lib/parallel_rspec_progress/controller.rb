require "ruby-progressbar"
require "drb/drb"

module ParallelRspecProgress
  class Controller
    attr_reader :progressbar

    def stop
      DRb.stop_service
    end

    def progressbar?
      @progressbar
    end

    def create_progressbar(total)
      @progressbar = ProgressBar.create(
        format: "%a %e %P% Processed: %c from %C %b\u{15E7}%i %p%% %t",
        progress_mark: ' ',
        remainder_mark: "\u{FF65}",
        starting_at: 0,
        total: total,
      )
    end
  end
end
