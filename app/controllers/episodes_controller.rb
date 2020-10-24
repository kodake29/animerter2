class EpisodesController < ApplicationController
  def index
    @anime = Anime.find(params[:anime_id])
    @episodes = Episode.where(anime_id: @anime.id)
  end

  def show
    @review = Review.new
    @anime = Anime.find(params[:anime_id])
    @episode = Episode.find(params[:id])
    @reviews = Review.page(params[:page]).reverse_order.where(episode_id: @episode.id, release_status: 0, private_status: 0).per(6)
  end


end
