class Symbol
  def to_proc
    proc { |obj, *args| obj.send(self, *args) }
  end
end

class Object
  def benchmark(cycles = 1, label = self, &block)
    
    durations = []
    cycles.times do
      start = Time.now
      yield
      finish = Time.now  
      durations << finish.to_f - start.to_f
    end
    
    total = durations.inject(0) { |sum, time| sum + time }
    puts "#{cycles.to_s + ' x ' if cycles > 1}#{label}: #{'%0.7f' % total}"
    puts "average: #{'%0.7f' % (total/cycles)}"
    puts "minimum: #{'%0.7f' % (durations.min)}"
    puts "maximum: #{'%0.7f' % (durations.max)}"
    puts "(first time: #{'%0.7f' % (durations.first)}"
  end
end