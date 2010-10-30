module Rubyvis
  # Alias for Rubyvis::Colors
  def self.Colors
    Rubyvis::Colors
  end
  def self.colors(*args)
    scale=Rubyvis::Scale.ordinal
    scale.range(*args)
    scale
  end
  module Colors
    def self.category10(*arguments)
      scale = Rubyvis.colors(
      "#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd",
      "#8c564b", "#e377c2", "#7f7f7f", "#bcbd22", "#17becf")
      scale.domain(*arguments) if arguments.size>0
      scale
    end
    def self.category19(*arguments)
      scale = Rubyvis.colors(
      "#9c9ede", "#7375b5", "#4a5584", "#cedb9c", "#b5cf6b",
      "#8ca252", "#637939", "#e7cb94", "#e7ba52", "#bd9e39",
      "#8c6d31", "#e7969c", "#d6616b", "#ad494a", "#843c39",
      "#de9ed6", "#ce6dbd", "#a55194", "#7b4173")
      scale.domain(*arguments) if arguments.size>0
      scale
    end
    def self.category20(*arguments)
      scale = Rubyvis.colors(
      "#1f77b4", "#aec7e8", "#ff7f0e", "#ffbb78", "#2ca02c",
      "#98df8a", "#d62728", "#ff9896", "#9467bd", "#c5b0d5",
      "#8c564b", "#c49c94", "#e377c2", "#f7b6d2", "#7f7f7f",
      "#c7c7c7", "#bcbd22", "#dbdb8d", "#17becf", "#9edae5")
      scale.domain(*arguments) if arguments.size>0
      scale
    end
  end
end
