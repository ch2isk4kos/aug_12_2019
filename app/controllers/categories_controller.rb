class CategoriesController < ApplicationController

    before_action :find_category, only: [:show]

    def index
        @categories = Category.all
    end

    def show
        @category_count = @category.rankings.count
        # binding.pry
    end

    private

    def category_params
        params.require(:category).permit(:title)
    end

    def find_category
        @category = Category.find(params[:id])
    end
end
