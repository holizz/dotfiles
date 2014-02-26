class Object
  public
  def pume
    public_methods.sort-Object.public_methods
  end
end

begin
  require 'rubygems'

  begin
    require 'wirble'

    module Wirble
      class History
        def save_history
          path, max_size, perms = %w{path size perms}.map { |v| cfg(v) }

          # read lines from history, and truncate the list (if necessary)
          lines = Readline::HISTORY.to_a # I removed .uniq from this line
          lines = lines[-max_size, -1] if lines.size > max_size

          # write the history file
          real_path = File.expand_path(path)
          File.open(real_path, perms) { |fh| fh.puts lines }
          say 'Saved %d lines to history file %s.' % [lines.size, path]
        end
      end
    end
    Wirble.init
  rescue LoadError
  end

  begin
    require 'ruby-debug'
    trap ('TSTP') { debugger }
  rescue LoadError
  end
end
