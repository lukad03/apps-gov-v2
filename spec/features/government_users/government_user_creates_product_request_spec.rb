require "rails_helper"

feature "A Government User creates a Product Request" do
  before { login_as(user, scope: :government_user) }

  context "that is unique" do
    scenario "and successfully creates the request" do
      visit product_path(product)

      click_on t("products.product_sidebar.get_product")

      fill_in "Authorizing official email", with: "email@email.com"
      fill_in "Contract officer email", with: "email@email.com"
      click_on "Create Product request"

      expect(page).to have_text t("product_requests.create.success")
    end
  end

  context "that is not unique" do
    scenario "and sees an error" do
      create(:product_request, product: product, user: user)
      visit product_path(product)

      click_on t("products.product_sidebar.get_product")

      fill_in "Authorizing official email", with: "email@email.com"
      fill_in "Contract officer email", with: "email@email.com"
      click_on "Create Product request"

      expect(page).to have_text t("product_requests.create.failure")
    end
  end

  def product
    @product ||= create(:product)
  end

  def user
    @user ||= create(:user, :as_gov_user)
  end
end
