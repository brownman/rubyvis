require 'rubyvis/scene/svg_panel'
require 'rubyvis/scene/svg_bar'
require 'rubyvis/scene/svg_rule'
require 'rubyvis/scene/svg_label'
require 'rubyvis/scene/svg_line'
require 'rubyvis/scene/svg_dot'
require 'rubyvis/scene/svg_area'
require 'rubyvis/scene/svg_wedge'
require 'rubyvis/scene/svg_image'
require 'rubyvis/scene/svg_curve'

class REXML::Element # :nodoc:
  attr_accessor :_scene
end

module Rubyvis
  def self.Scene # :nodoc:
    Rubyvis::SvgScene
  end
  module SvgScene # :nodoc:
    #include REXML
    def self.svg
      "http://www.w3.org/2000/svg"
    end;
    def self.xmlns
      "http://www.w3.org/2000/xmlns"
    end
    def self.xlink
      "http://www.w3.org/1999/xlink"
    end
    def self.xhtml
      "http://www.w3.org/1999/xhtml"
    end
    @scale=1
    def self.scale
      @scale
    end
    def self.scale=(v)
      @scale=v
    end
    def self.implicit
      svg={
        "shape-rendering"=> "auto",
        "pointer-events"=> "painted",
        "x"=> 0,
        "y"=> 0,
        "dy"=> 0,
        "text-anchor"=> "start",
        "transform"=> "translate(0,0)",
        #"fill"=> "none",
        "fill-opacity"=> 1,
        "stroke"=> "none",
        "stroke-opacity"=> 1,
        "stroke-width"=> 1.5,
        "stroke-linejoin"=> "miter"
      }
      css={"font"=>"10px sans-serif"}

      {:svg=>svg,:css=>css}
    end

    def self.update_all(scenes)
      puts "update_all: #{scenes.inspect}" if $DEBUG
      if (scenes.size>0 and scenes[0].reverse and scenes.type!='line' and scenes.type!='area')
        scenes=scenes.reverse
      end
      
      self.remove_siblings(self.send(scenes.type, scenes))
    end
    def self.remove_siblings(e)
      while(e)
        n=e.next_sibling_node
        e.remove
        e=n
      end
    end
    def self.create(type)
      el=REXML::Element.new "#{type}"
      if type=='svg'
        el.add_namespace(self.svg)
        #el.add_namespace("xmlns:xmlns", self.xmlns)
        el.add_namespace("xmlns:xlink", self.xlink)
      end
      el
    end

    def self.append(e,scenes,index)
      e._scene=OpenStruct.new({:scenes=>scenes, :index=>index})
      e=self.title(e,scenes[index])

      if(!e.parent)
        scenes._g.add_element(e)
      end
      return e.next_sibling_node
    end
    
    # Applies a title tooltip to the specified element <tt>e</tt>, using the
    # <tt>title</tt> property of the specified scene node <tt>s</tt>. Note that
    # this implementation does not create an SVG <tt>title</tt> element as a child
    # of <tt>e</tt>; although this is the recommended standard, it is only
    # supported in Opera. Instead, an anchor element is created around the element
    # <tt>e</tt>, and the <tt>xlink:title</tt> attribute is set accordingly.
    #
    # @param e an SVG element.
    # @param s a scene node.
    
    def self.title(e,s)
      a = e.parent
      a=nil if (a and (a.tag_name != "a"))
      if (s.title) 
        if (!a) 
          a = self.create("a")
          e.parent.replace_child(a, e) if (e.parent)
          a.add_element(e)
        end
        a.add_attribute('xlink:title',s.title)
        return a;
      end
      a.parent_node.replace_child(e, a) if (a) 
      e
    end
    
    def self.expect(e, type, attributes, style=nil)

      if (e)
        e = e.elements[1] if (e.name == "a")
        if (e.name != type)
          n = self.create(type);
          e.parent.replace_child(e, n);
          e = n
        end
      else
        e = self.create(type)
      end
      attributes.each {|name,value|
        value = nil if (value == self.implicit[:svg][name])
        if (value.nil?)
          e.delete_attribute(name)
        else
          e.attributes[name]=value
        end
      }
      
      if(style)
        base_style=e.attributes['style']
        base_style||=""
        array_styles={}
        base_style.split(";").each {|v|
          v=~/\s*(.+)\s*:\s*(.+)/
          array_styles[$1]=$2
        }
        style.each {|name,value|
          value=nil if value==self.implicit[:css][name]
          if (value.nil?)
            array_styles.delete(name)
          else
            
            array_styles[name]=value
          end
        }
        if array_styles.size>0
          e.attributes["style"]=array_styles.map {|k,v| "#{k}:#{v}"}.join(";")
        end
      end
      e
    end

  end
end
