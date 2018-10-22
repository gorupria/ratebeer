require 'rails_helper'

describe "Beerlist page" do
  before :all do
    Capybara.register_driver :selenium do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: ['headless', 'disable-gpu']  }
      )

      Capybara::Selenium::Driver.new app,
        browser: :chrome,
        desired_capabilities: capabilities      
    end
    WebMock.disable_net_connect!(allow_localhost: true) 
  end

  before :each do
    @brewery1 = FactoryBot.create(:brewery, name:"Koff")
    @brewery2 = FactoryBot.create(:brewery, name:"Schlenkerla")
    @brewery3 = FactoryBot.create(:brewery, name:"Ayinger")
    @style1 = Style.create name:"Lager"
    @style2 = Style.create name:"Rauchbier"
    @style3 = Style.create name:"Weizen"
    @beer1 = FactoryBot.create(:beer, name:"Nikolai", brewery: @brewery1, style:@style1)
    @beer2 = FactoryBot.create(:beer, name:"Fastenbier", brewery:@brewery2, style:@style2)
    @beer3 = FactoryBot.create(:beer, name:"Lechte Weisse", brewery:@brewery3, style:@style3)
  end

  it "shows one known beer", js:true do
    visit beerlist_path
    find('table').find('tr:nth-child(3)')
    expect(page).to have_content "Fastenbier"
  end

  it "names are sorted in asc order", js:true do
    visit beerlist_path
    first_beer = find('table').find('tr:nth-child(2)')
    second_beer = find('table').find('tr:nth-child(3)')
    third_beer = find('table').find('tr:nth-child(4)')
    expect(first_beer).to have_content "Fastenbier"
    expect(second_beer).to have_content "Lechte Weisse"
    expect(third_beer).to have_content "Nikolai"
  end

  it "gets sorted when clicked on style column", js:true do 
    visit beerlist_path
    page.find(:css, "#style").click()
    first_style = find('table').find('tr:nth-child(2)')
    second_style = find('table').find('tr:nth-child(3)')
    third_style = find('table').find('tr:nth-child(4)')
    expect(first_style).to have_content "Lager"
    expect(second_style).to have_content "Rauchbier"
    expect(third_style).to have_content "Weizen"
  end

  it "gets sorted when clicked on brewery column", js:true do 
    visit beerlist_path
    page.find(:css, "#brewery").click()
    first_brewery= find('table').find('tr:nth-child(2)')
    second_brewery = find('table').find('tr:nth-child(3)')
    third_brewery = find('table').find('tr:nth-child(4)')
    expect(first_brewery).to have_content "Ayinger"
    expect(second_brewery).to have_content "Koff"
    expect(third_brewery).to have_content "Schlenkerla"
  end
end
