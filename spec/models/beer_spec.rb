require 'rails_helper'

RSpec.describe Beer, type: :model do

  it "should set the name, style and brewery of the beer" do
    beer = Beer.new name: "karhu", style_id: 1 , brewery_id: 1
    expect(beer.name).to eq("karhu")
    expect(beer.style_id).to eq(1)
    expect(beer.brewery_id).to eq 1
  end
  
  describe "with proper value" do
    let(:beer){ FactoryBot.create(:beer) }

    it "is saved if name, style and brewery_id is set" do
      expect(beer.valid?).to be(true)
      expect(Beer.count).to eq 1
    end
  end

  it "is not saved if name is not set" do 
    beer = Beer.create style_id: 1 , brewery_id: 1
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq 0
  end

  it "is not saved if style is not set" do 
    beer = Beer.create name: "karhu", brewery_id:1
    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq 0
  end
end


