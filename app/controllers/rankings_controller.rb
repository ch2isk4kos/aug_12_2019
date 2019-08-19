class RankingsController < ApplicationController

    before_action :find_ranking, only: [:show]
    before_action :redirect_if_not_logged_in, only: [:new, :create]

    def index
        @rankings = Ranking.all.order("created_at DESC")
    end

    def new
        if params[:category_id]     # Check params for nested resource/form
            @category = Category.find_by(id: params[:category_id])
        end

        @ranking = current_user.rankings.build            # build user      (has_many)
        @ranking.build_category                           # build category  (belongs_to)

        5.times do                                        # selections
            selection_builder = @ranking.selections.build # .objects.build  => builds a has_many relationship
            selection_builder.build_player                # .build_object   => builds a belongs_to relationship
        end
    end

    def create
        @ranking = current_user.rankings.build(ranking_params) # @ranking = Ranking.new(ranking_params)

        if @ranking.save
            redirect_to ranking_path(@ranking)
        else
            render :new
        end

    end

    def show; end

    private

    def ranking_params
        params.require(:ranking).permit(:content, :user_id, :category_id, selections_attributes: [:player_id, player_attributes: [:name]], player_ids: [])
    end

    def find_ranking
        @ranking = Ranking.find_by(id: params[:id])
    end

end
