require_relative '../lib/recipe'
require_relative '../lib/ingredient'

RSpec.describe Recipe do
  # Implicit subject (Recipe)
  subject { described_class.new("Pasta", [], ["Boil water", "Add pasta"]) }

  it "has a name" do
    expect(subject.name).to eq("Pasta")
  end

  it "starts with no ingredients" do
    expect(subject.ingredients).to be_empty
  end

  # Explicit subject
  describe "with ingredients" do
    let(:tomato) { Ingredient.new("Tomato") }
    let(:cheese) { Ingredient.new("Cheese") }
    subject { described_class.new("Pizza", [tomato, cheese]) }

    it "lists ingredient names" do
      expect(subject.ingredient_names).to contain_exactly("Tomato", "Cheese")
    end

    it "is vegetarian if all ingredients are vegetarian" do
      expect(subject).to be_vegetarian
    end
  end

  # subject! (let!)
  describe "with subject!" do
    let(:egg) { Ingredient.new("Egg") }
    subject!(:omelette) { described_class.new("Omelette", [egg]) }

    it "creates the recipe before each example" do
      expect(omelette.name).to eq("Omelette")
    end
  end

  # subject with parameters
  describe "with custom subject block" do
    subject(:salad) { described_class.new("Salad", [Ingredient.new("Lettuce")]) }

    it "has the correct name" do
      expect(salad.name).to eq("Salad")
    end
  end

  # Nested context with subject
  describe "nested context" do
    subject { described_class.new("Soup") }

    context "after adding an ingredient" do
      before { subject.add_ingredient(Ingredient.new("Carrot")) }
      it "has one ingredient" do
        expect(subject.ingredients.size).to eq(1)
      end
    end
  end

  describe "#steps_list" do
    subject { described_class.new("Pasta", [], ["Boil water", "Add pasta"])}
    it "returns steps as a numbered list string" do
      expect(subject.steps_list).to eq("1. Boil water\n2. Add pasta")
    end
  end

  describe "#remove_ingredient" do 
    let(:tomato) { Ingredient.new("Tomato") }
    let(:cheese) { Ingredient.new("Cheese") }
    subject(:pizza) { described_class.new("Pizza", [tomato, cheese]) }

    it "can remove an ingredient by name" do
      pizza.remove_ingredient(tomato)
      expect(pizza.ingredients).to_not include([tomato])
    end
  end
end
