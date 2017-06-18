require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  render_views

  let(:json) { JSON.parse(response.body) }
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      # expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  #
  #   it "loads all of the products into @products" do
      # product1, product2 = Product.create!(name:"hello", description: 'hhh', rating: 2), Product.create!(name:"helleeo", description: 'hhh', rating: 2)
  #     get :index
  #
  #     expect(assigns(:products)).to match_array([product1, product2])
  #   end

    it "loads all of the posts into @products" do
      camille = User.create!(email:"camillette@gmail.com", password:"azerty")
      product1, product2 = Product.create!(name:"hello", rating: 2, user: camille), Product.create!(name:"helleeo", rating: 2, user: camille)
      # product1, product2 = Product.create!(name:"hello", rating: 2), Product.create!(name:"helleeo", rating: 2)
      get :index

      expect(assigns(:products)).to match_array([product1, product2])
    end
  end

  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      camille = User.create!(email:"camillette@gmail.com", password:"azerty")
      product1 = Product.create!(name:"hello", rating: 2, user: camille)

      get :show, params: {id:  product1.id}

      # get "products/:id", params: { id: product1.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  # describe 'DELETE #destroy' do
  #
  # context 'when resource is found' do
  #   it 'responds with 200'
  #   it 'shows the resource'
  # end
  #
  # context 'when resource is not found' do
  #   it 'responds with 404'
  # end
  #
  # context 'when resource is not owned' do
  #   it 'responds with 404'
  # end
  # end
end
