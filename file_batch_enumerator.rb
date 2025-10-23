class FileBatchEnumerator
  include Enumerable

  def initialize(file_path, batch_size)
    @file_path = file_path
    @batch_size = batch_size
  end

  def each
    File.open(@file_path, "r") do |file|
      batch = []
      file.each_line do |line|
        batch << line.chomp
        if batch.size == @batch_size
          yield batch
          batch = []
        end
      end
      yield batch unless batch.empty?
    end
  end
end

# Створення тестового файлу
File.write("test.txt", (1..120).map { |i| "Рядок #{i}" }.join("\n"))

# Використання
enumerator = FileBatchEnumerator.new("test.txt", 30)
enumerator.each_with_index do |batch, index|
  puts "Батч ##{index + 1}:"
  puts batch.join(", ")
end