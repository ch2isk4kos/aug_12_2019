class PlayersController < ApplicationController

    before_action :find_player, only: [:show]

    def index
        @players = Player.alphabetical_order
        # binding.pry
    end

    def new
        @player = Player.new
        # binding.pry
    end

    def create
        @player = Player.new(player_params)

        if @player.save
            redirect_to player_path(@player)
        else
            render :new
        end
    end

    def show
        redirect_to players_path if !@player
    end

    private

    def player_params
        params.require(:player).permit(:name)
    end

    def find_player
        @player = Player.find(params[:id])
    end

end
