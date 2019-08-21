class RankingsController < ApplicationController

    before_action :find_ranking, only: [:show]
    before_action :redirect_if_not_logged_in, only: [:new, :create]

    def index
        @rankings = Ranking.all.order("created_at DESC")
    end

    def new
        if params[:category_id]
            @category = Category.find_by(id: params[:category_id])
        end

        @ranking = current_user.rankings.build
        # @ranking.build_category

        5.times do
            selection_builder = @ranking.selections.build
            selection_builder.build_player
        end
    end

    def create
        @ranking = current_user.rankings.build(ranking_params)

        # binding.pry

        if @ranking.save
            redirect_to ranking_path(@ranking)
        else
            render :new
        end
    end

    def show
    end

    private

    def ranking_params
        params.require(:ranking).permit(
            :content,
            :user_id,
            :category_id,
            selections_attributes: [:player_id, player_attributes: [:name]],
            player_ids: []
        )
    end

    def find_ranking
        @ranking = Ranking.find_by(id: params[:id])
    end

end
