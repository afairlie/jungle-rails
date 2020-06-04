require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
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

  scenario "Cart count increases by one when product added to cart" do
    # ACT
    visit root_path

    expect(page).to have_text 'My Cart (0)'

    first('.product').find_button('Add').click

    # DEBUG
    save_screenshot('add_to_cart_spec.png')

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end


end
