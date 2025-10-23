class EmailAdapter
  def deliver(message)
    puts "Email: #{message}"
  end
end

class SlackAdapter
  def deliver(message)
    puts "Slack: #{message}"
  end
end

class Notifier
  def initialize(adapter)
    @adapter = adapter
  end

  def notify(message)
    @adapter.deliver(message)
  end
end

# Вибір адаптера через аргументи
adapter_type = ARGV[0] || "email"
message = ARGV[1] || "Привіт!"

adapter = case adapter_type
          when "email" then EmailAdapter.new
          when "slack" then SlackAdapter.new
          else raise "Невідомий адаптер"
          end

Notifier.new(adapter).notify(message)