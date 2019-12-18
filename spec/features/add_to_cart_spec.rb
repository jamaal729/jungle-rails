require 'rails_helper'

RSpec.feature "Visitor adds a product to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )

    end
  end

  scenario "The item is added to the cart" do
    # ACT
    visit root_path

    expect(page).to have_content 'My Cart (0)'
    
    find('.product .button_to').click
    # DEBUG / VERIFY

    expect(page).to have_content 'My Cart (1)'

    save_screenshot
  end

end


