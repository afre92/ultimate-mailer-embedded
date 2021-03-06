# frozen_string_literal: true

class ReviewsController < ShopifyAuthenticatedController
  before_action :find_store
  before_action :set_daterange, only: :index

  def index
    @exported = params[:exported] || false
    @reviews = @shop.reviews.where(review_status: 'completed').paginate(page: params[:page], per_page: 10)
  end

  def show
    @review = @shop.reviews.find(params['id'])
    @customer = JSON.parse(@review.order.customer)
  end

  def update
    review = @shop.reviews.find(params['id'])
    if review.update(exported: !review.exported)
      flash[:success] = 'Review updated'
    else
      flash[:danger] = 'Something is wrong'
    end
    redirect_to reviews_path
  end

  private

    def review_params
      params.require(:review).permit( :rating, :title, :description, :review_status, images: [])
    end
    
    def find_store
      @shop = Shop.find_by(shopify_domain: session[:shopify_domain])
      @view = 'reviews'
    end
end
