require 'spec_helper'

describe String do
  describe ".anglicize" do
    it "works with replaceable word in lower case" do
      expect("blue is warmest color".anglicize).to eq "blue is warmest colour"
    end

    it "doesn't replace words that are already anglicized" do
      expect("blue is warmest colour".anglicize).to eq "blue is warmest colour"
    end

    it "works with replaceable word in upper case" do
      expect("BLUE IS WARMEST COLOR".anglicize).to eq "BLUE IS WARMEST COLOUR"
    end

    it "works with replaceable word in mixed case" do
      expect("Blue Is Warmest Color".anglicize).to eq "Blue Is Warmest Colour"
    end
  end

  describe ".americanize" do
    it "works with replaceable word in lower case" do
      expect("blue is warmest colour".americanize).to eq "blue is warmest color"
    end

    it "doesn't replace words that are already anglicized" do
      expect("blue is warmest color".americanize).to eq "blue is warmest color"
    end

    it "works with replaceable word in upper case" do
      expect("AEON COLOUR".americanize).to eq "EON COLOR"
    end

    it "works with replaceable word in mixed case" do
      expect("Blue Is Warmest Colour".americanize).to eq "Blue Is Warmest Color"
    end
  end

  describe ".has_alternate_english_spelling?" do
    it "returns true if a word can be replaced" do
      expect("Blue Is Warmest Color".has_alternate_english_spelling?).to be_true
    end

    it "returns false if no words can be replaced" do
      expect("Aeon Colour".has_alternate_english_spelling?).to be_false
    end
  end

  describe ".has_altenate_american_spelling?" do
    it "returns true if a word can be replaced" do
      expect("Blue Warmest Colour".has_alternate_american_spelling?).to be_true
    end

    it "returns false if no words can be replaced" do
      expect("Eon Color".has_alternate_american_spelling?).to be_false
    end
  end
end