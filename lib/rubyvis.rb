require 'date'
require 'ostruct'
require 'rexml/document'
require 'rexml/formatters/default'

require 'pp'
require 'rubyvis/internals'
require 'rubyvis/sceneelement'
require 'rubyvis/property'
require 'rubyvis/nest'
require 'rubyvis/flatten'

require 'rubyvis/javascript_behaviour'
require 'rubyvis/format'
require 'rubyvis/mark'
require 'rubyvis/scale'
require 'rubyvis/histogram'

require 'rubyvis/color/color'
require 'rubyvis/color/colors'

require 'rubyvis/layout'
require 'rubyvis/dom'

require 'rubyvis/scene/svg_scene'
require 'rubyvis/transform'
require 'rubyvis/mark/shorcut_methods'


module Rubyvis
  @document=nil
  # Rubyvis version
  VERSION = '0.3.3' 
  # Protovis API on which current Rubyvis is based
  PROTOVIS_API_VERSION='3.3'
  # You actually can do it! http://snipplr.com/view/2137/uses-for-infinity-in-ruby/
  Infinity=1.0 / 0 
  #
  # :section: basic methods
  #
  
  # Returns the passed-in argument, +x+; the identity function. This method
  # is provided for convenience since it is used as the default behavior for a
  # number of property functions.
  #
  # @param [Object] x, a value.
  # @return [Object] the value +x+.
  def self.identity
    lambda {|x,*args| x}
  end
  
 # Returns <tt>self.index</tt>. This method is provided for convenience for use
 # with scales. For example, to color bars by their index, say:
 #
 # <pre>.fill_style(Rubyvis::Colors.category10().by(Rubyvis.index))</pre>
 #
 # This method is equivalent to <tt>lambda {self.index}</tt>, but more
 # succinct. Note that the <tt>index</tt> property is also supported for
 # accessor functions with {@link Rubyvis.max}, {@link Rubyvis.min} and other array
 # utility methods.
 #
 # @see Rubyvis::Scale
 # @see Rubyvis::Mark#index
  def self.index
    lambda {|*args| self.index}
  end
  
  def self.child
    lambda {|*args| self.child_index}
  end
  def self.parent
    lambda {|*args| self.parent.index}
  end
  def self.clear_document
    @document=REXML::Document.new
    @document.add_element("document")
  end
  def self.document
    if @document.nil?
      @document=REXML::Document.new
      @document.add_element("document")
    end
    @document.root
  end
  def self.to_svg
    s=""
    @document.write(s)
    s
  end
end

# Alias for Rubyvis module
# @return [Module] Rubyvis module
def pv
  Rubyvis
end
