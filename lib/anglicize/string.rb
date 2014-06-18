require 'yaml'

# Extensions for string class.
class String
  # @return [String] a copy of the string converted into English spelling.
  def anglicize
    result = self.dup
    scan(WORD_RE).uniq.each do |word|
      result.gsub!(/\b#{word}\b/, get_anglicized_word(word))
    end
    result
  end

  # Converts the string into English spelling.
  # @return [String] the string converted into English spelling
  def anglicize!
    self.replace(self.anglicize)
  end

  # @return [String] a copy of the string converted into American spelling.
  def americanize
    result = self.dup
    scan(WORD_RE).uniq.each do |word|
      result.gsub!(/\b#{word}\b/, get_americanized_word(word))
    end
    result
  end

  # Converts the string into American spelling.
  # @return [String] the string converted into American spelling
  def americanize!
    self.replace(self.americanize)
  end

  # @return [Boolean] a value indicating whether the English spelling differs.
  def has_alternate_english_spelling?
    self != anglicize
  end

  # @return [Boolean] a value indicating whether the American spelling differs.
  def has_alternate_american_spelling?
    self != americanize
  end

  # @param word [String] used as the case template
  # @return [String] a copy of the string with the same case as the template.
  def copy_case(word)
    result = ""
    if word.upcase == word
      result = self.upcase
    elsif word.downcase == word
      result = self.downcase
    else
      self.chars.each_with_index do |char, index|
        word_char = word[index] || "a"
        result << (word_char.upcase == word_char ? char.upcase : char.downcase)
      end
    end
    result
  end

  # Changes the string to have the same case as the string parameter.
  # @param word [String] used as the case template
  # @return [String] the string with the same case as the template.
  def copy_case!(word)
    self.replace(self.copy_case)
  end

  private

  # A regular expression for identifying words
  WORD_RE = /\b[a-zA-Z]+\b/

  def get_anglicized_word(word)
    # Load american to english conversion hash if not already loaded
    @@american_to_english ||= load_american_to_english
    key = word.downcase
    (@@american_to_english[key] || word).copy_case(word)
  end

  def get_americanized_word(word)
    # Load english to american hash if not already loaded
    @@english_to_american ||= load_english_to_american
    key = word.downcase
    (@@english_to_american[key] || word).copy_case(word)
  end

  # Load alternate spellings if not already loaded and insert values and keys
  def load_american_to_english
    @@alternate_spellings ||= load_alternate_spellings
    @@alternate_spellings.invert
  end

  # Load alternate spellings if not already loaded
  def load_english_to_american
    @@alternate_spellings ||= load_alternate_spellings
  end

  def load_alternate_spellings
    dirname = File.dirname(File.expand_path(__FILE__))
    file_path = File.join(dirname, "alternate_spellings.yml")
    YAML::load(File.open(file_path))
  end
end