require 'rails_helper'
require 'rspec-rails'

RSpec.describe Api::V1::ProductsController, type: :controller do
  # render_views

  # let(:json) { JSON.parse(response.body) }
  # parsed_body = JSON.parse(response.body)
  # parsed_body["foo"].should == "bar"

  # describe "GET /listings.json #index" do
  #   before do
  #     get :index, format: :json
  #   end
  #
  #   context 'all listings' do
  #     it 'returns the listings' do
  #       expect(json.collect{|l| l["name"]}).to include(@product1.name)
  #     end
  #   end
  # end

  # let(:user) { User.create(email: "camillette@gmail.com", password: "azerty") }
  # let(:product) { Product.create( name: "Persian", user: user ) }
  let(:user) { User.create(email: "camillette@gmail.com", password: "azerty") }
  let(:product1) { Product.create( name: "Persian", rating: 3, user: user ) }
  let(:product2) { Product.create( name: "Persian2", rating: 3, user: user ) }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      # request.accept = "application/json"
      get :index, format: 'json'
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the products into @products" do
      # camille = User.create!(email:"camillette@gmail.com", password:"azerty")
      # product1, product2 = Product.create!(name:"hello", rating: 2, user: user), Product.create!(name:"helleeo", rating: 2, user: user)
      get :index, format: 'json'
      expect(assigns(:products)).to match_array([product1, product2])
    end
  end

  describe "GET #show" do

    before do
      get :show, params: { id: product1.id}, format: 'json'
    end
    # camille = User.create!(email:"camillette@gmail.com", password:"azerty")
    # product1, product2 = Product.create!(name:"hello", rating: 2, user: camille), Product.create!(name:"helleeo", rating: 2, user: camille)
    it "responds successfully with an HTTP 200 status code" do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "response with JSON body containing expected Product attributes" do
      hash_body = nil
      expect { hash_body = JSON.parse(response.body).with_indifferent_access }.not_to raise_exception
      expect(hash_body).to match({
        "name": 'Persian',
        "rating": 3
        })
    end

    it "respond body JSON with attributes" do
      # expect(response.body).to look_like_json
      expect(assigns(:product)).to match({
        "name": 'Persian',
        "rating": 3
      })
    end

    it "loads the product into @product" do
      # camille = User.create!(email:"camillette@gmail.com", password:"azerty")
      # product1 = Product.create!(name:"hello", rating: 2, user: camille)

      # get :show, params: {id:  product1.id}, format: 'json'
      expect(assigns(:product)).to contain_exactly({
        "name": 'Persian',
        "rating": 3
      })
    end
  end

  describe "POST #create" do
    it 'should 401 if bad credentials' do
      # Given the user and his bar

      # When
      post :create, format: 'json',
      { "product":
        { "name": "New plrrsssssdddddrrace", "rating": 2 }
      }.to_json =>
      {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'x-user-email' => 'toto',
        'x-user-token' => 'toto'
      }

      # Then
      puts response.body
      expect(response.response_code).to eq 401
      #expect_status 401
    end
  end

#   describe "DELETE /v1/categories/:product_id" do
#     before(:each) do
#         #   Login User/Token
#         product = Fabricate(:product)
#         product2 = Fabricate(:product)
#         delete "/v1/categories/#{product.id}"
#     end
#
#     it 'should return status 200' do
#         expect(response.status).to eq 200
#     end
#
#     it 'should delete the product' do
#         expect(Category.all).to eq product2
#     end
# end

  describe 'DELETE #destroy' do
    before do
      # request.accept = "application/json"
      # camille = User.create!(email:"camillette@gmail.com", password:"azerty")
      # product1, product2 = Product.create!(name:"hello", rating: 2, user: camille), Product.create!(name:"helleeo", rating: 2, user: camille)
        #   Login User/Token
      delete :destroy, params: { id: product1.id}, format: 'json'
    end


    it 'should return status 200' do
        expect(response.status).to eq 200
    end

    it 'should delete the product' do
        expect(Product.all).to eq product2
    end
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
  end
end
