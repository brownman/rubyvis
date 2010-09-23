require 'protoruby/format'
require 'protoruby/label'
require 'protoruby/mark'
require 'protoruby/bar'
require 'protoruby/panel'
require 'protoruby/scale'
require 'date'
module Protoruby
  VERSION = '1.0.0'
  Infinity=1e+50
  def self.pv
    Protoruby
  end
  def self.Scale
    Protoruby::Scale
  end
  def self.Format
    Protoruby::Format
    
  end
  def self.identity
    lambda {|x| x}
  end
  def self.log(x,b)
    Math::log(x).quo(Math::log(b))
  end
  def self.logFloor(x,b)
    (x>0)  ? b**(pv.log(x,b).floor) : b**(-(-pv.log(-x,b)).floor)
  end
  
  def self.search (array, value, f=nil)
    f = identity if (f.nil?) 
    low = 0
    high = array.size - 1;
    while (low <= high)
      mid = (low + high) >> 1
      midValue = f.call(array[mid]);
      if (midValue < value)
        low = mid + 1;
      elsif (midValue > value)
        high = mid - 1;
      else
        return mid;
      end
    end
    return -low - 1;
  end
  
  
  def self.range(*arguments)
    
    start, stop, step=arguments[0], arguments[1],arguments[2]
    if (arguments.size == 1) 
      stop = start;
      start = 0;
    end
    step = 1 if (step.nil?)
    raise "range must be finite" if step==0
    array = []
    i = 0
    
    stop = stop- (stop - start) * 1e-10 #// floating point precision!
    j = start + step * i
    if (step < 0)
      while (j > stop) 
        array.push(j)
        i+=1
        j = start + step * i
        
      end
     else 
      while (j < stop)
        array.push(j)
        i+=1
        j = start + step * i
        

      end
    end
    array
  end
  
end