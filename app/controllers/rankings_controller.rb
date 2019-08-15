class RankingsController < ApplicationController

    before_action :find_ranking, only: [:show]

    def index
        @rankings = Ranking.all.order("created_at DESC")
    end

    def new
        if params[:user_id] && @user = User.find_by_id(params[:user_id])
            @ranking = @user.rankings.build # build user (has_many)
            # category

            5.times do # selections
                selection_builder = @ranking.selections.build # .build == builds a has_many relationship
                selection_builder.build_player # .build_object == builds a belongs_to relationship
            end
        else
            @ranking = Ranking.new
            5.times do # selections
                selection_builder = @ranking.selections.build # .build == builds a has_many relationship
                selection_builder.build_player # .build_object == builds a belongs_to relationship
            end

        end
    end

    def create
        @ranking = current_user.rankings.build(ranking_params) # @ranking = Ranking.new(ranking_params)
        binding.pry
        if @ranking.save
            redirect_to ranking_path(@ranking)
        else
            render :new
        end

    end

    def show; end

    private

    def ranking_params
        params.require(:ranking).permit(:description, player_ids: [], selections_attributes: [:player_id, player_attributes: [:name]])
    end

    def find_ranking
        @ranking = Ranking.find(params[:id])
    end

end
