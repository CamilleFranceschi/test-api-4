class Api::V1::ProductsController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]
  def index
    # @products=policy_scope(Product).order(name: :asc)
    @products=Product.all.order(name: :asc)
  end

  def show
  end

  def update
    if @product.update(product_params)
      render :show
    else
      render_error
    end
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user
    authorize @product
    if @product.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
    # authorize @product
  end

  def product_params
    params.require(:product).permit(:name,:rating)
  end

  def render_error
    render json: { errors: @product.errors.full_messages },
      status: :unprocessable_entity
      # Status 422, what we sent to the API is not good
  end
end
