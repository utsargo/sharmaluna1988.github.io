module Jekyll
  module AsciiFilter
    def convert_ascii(input)
      input.tr("áàâäãåçéèêëíìîïñóòôöõúùûü", "aaaaaaaceeeiiiinooooouuu")
          .tr("ÁÀÂÄÃÅÇÉÈÊËÍÌÎÏÑÓÒÔÖÕÚÙÛÜ", "AAAAAAACEEEIIIINOOOOOUUU")
          .gsub(/[^a-zA-Z0-9\s-]/, '')
          .strip
          .gsub(/\s+/, '-')
    end
  end
end

Liquid::Template.register_filter(Jekyll::AsciiFilter)