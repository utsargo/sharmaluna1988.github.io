module BengaliTransliterator
  CONSONANTS = {
    'ক'=>'k','খ'=>'kh','গ'=>'g','ঘ'=>'gh','ঙ'=>'ng','চ'=>'ch','ছ'=>'chh','জ'=>'j','ঝ'=>'jh','ঞ'=>'n',
    'ট'=>'t','ঠ'=>'th','ড'=>'d','ঢ'=>'dh','ণ'=>'n','ত'=>'t','থ'=>'th','দ'=>'d','ধ'=>'dh','ন'=>'n',
    'প'=>'p','ফ'=>'ph','ব'=>'b','ভ'=>'bh','ম'=>'m','য'=>'y','র'=>'r','ল'=>'l','শ'=>'sh','ষ'=>'sh','স'=>'s',
    'হ'=>'h','ড়'=>'r','ঢ়'=>'rh','য়'=>'y'
  }

  VOWEL_SIGNS = {
    'া'=>'a','ি'=>'i','ী'=>'ee','ু'=>'u','ূ'=>'oo','ৃ'=>'ri','ে'=>'e','ৈ'=>'oi','ো'=>'o','ৌ'=>'ou'
  }

  INDEPENDENT_VOWELS = {
    'অ'=>'a','আ'=>'aa','ই'=>'i','ঈ'=>'ee','উ'=>'u','ঊ'=>'oo','ঋ'=>'ri','এ'=>'e','ঐ'=>'oi','ও'=>'o','ঔ'=>'ou'
  }

  SPECIALS = {
    'ং'=>'ng','ঃ'=>'h','ঁ'=>'n'
  }

  HASANTA = '্'

  def self.transliterate(text)
    chars = text.chars
    result = ''
    i = 0

    while i < chars.length
      current = chars[i]
      next_char = chars[i + 1]
      next_next = chars[i + 2]

      if INDEPENDENT_VOWELS.key?(current)
        result << INDEPENDENT_VOWELS[current]
        i += 1
      elsif CONSONANTS.key?(current)
        consonant = CONSONANTS[current]

        if next_char == HASANTA && CONSONANTS.key?(next_next)
          # True conjunct cluster: skip the 'a'
          result << consonant
          i += 2
        elsif VOWEL_SIGNS.key?(next_char)
          result << consonant + VOWEL_SIGNS[next_char]
          i += 2
        elsif CONSONANTS.key?(next_char)
          # No hasanta between two consonants: insert implicit 'a'
          result << consonant + 'a'
          i += 1
        else
          # End of word or vowel/consonant with no need for 'a'
          result << consonant
          i += 1
        end
      elsif VOWEL_SIGNS.key?(current)
        result << VOWEL_SIGNS[current]
        i += 1
      elsif SPECIALS.key?(current)
        result << SPECIALS[current]
        i += 1
      elsif current == HASANTA
        i += 1
      else
        result << current
        i += 1
      end
    end

    result
  end
end

# Add as a custom Liquid filter
module Jekyll
  module BengaliFilters
    def transliterate_bengali(input)
      BengaliTransliterator.transliterate(input.to_s)
    end
  end
end

Liquid::Template.register_filter(Jekyll::BengaliFilters)