require 'rails_helper'

RSpec.feature "Visitor clicks to select a product on the home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        # image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )

    end
  end

  scenario "They are directed to the selected product's page" do
    # ACT
    # visit root_path
    visit root_path
    click_link('Details',:match => :first)

    # DEBUG
    save_screenshot("selected_product.png")

    # VERIFY
    expect(page).to have_css 'article.product-detail', count: 1
  end

end
