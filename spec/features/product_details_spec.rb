require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the product detail page by clicking a product" do
    # ACT
    visit root_path

    first('.product').find_link('Details').click

    # DEBUG
    save_screenshot('product_details_spec.png')

    # VERIFY
    expect(page).to have_css '.products-show', count: 1
  end
end
