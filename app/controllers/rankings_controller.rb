class RankingsController < ApplicationController

    before_action :find_ranking, only: :show

    def index
        @rankings = Ranking.all.order("created_at DESC")
    end

    def new
        # @category = Category.find(params[:id])

        if (params[:user_id] && @user = User.find_by_id(params[:user_id])) && (params[:category_id] && @category = Category.find_by_id(params[:category_id]))
            @ranking = @user.rankings.build                   # build user      (has_many)
            @ranking.build_category                           # build category  (belongs_to)

            5.times do                                        # selections
                selection_builder = @ranking.selections.build # .objects.build  => builds a has_many relationship
                selection_builder.build_player                # .build_object   => builds a belongs_to relationship
            end
        else
            @ranking = Ranking.new
            # @ranking.user_id = params[:user_id]
            # @ranking.category_id = params[:category_id]

            5.times do                                        # selections
                selection_builder = @ranking.selections.build # .build          => builds a has_many relationship
                selection_builder.build_player                # .build_object   => builds a belongs_to relationship
            end
        end

    end

    def create
        @ranking = current_user.rankings.build(ranking_params) # @ranking = Ranking.new(ranking_params)
        @ranking.build_category

        # binding.pry

        if @ranking.save
            redirect_to ranking_path(@ranking)
        else
            render :new
        end

    end

    def show
        # binding.pry
    end

    private

    def ranking_params
        params.require(:ranking).permit(:content, selections_attributes: [:player_id, player_attributes: [:name]], player_ids: [])
    end

    def find_ranking
        @ranking = Ranking.find(params[:id])
    end

end
