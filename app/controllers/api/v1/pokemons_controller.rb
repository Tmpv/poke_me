class Api::V1::PokemonsController < ApplicationController
  before_action :set_pokemon, only: :show

  def index
    @pokemons = Pokemon.includes(:kinds).all
    render json: @pokemons.as_json(only: %i[name id], include: { kinds: { only: %i[name] } })
  end

  def show
    render json: @pokemon.as_json(include: { kinds: { only: %i[name id] } }, except: %i[created_at updated_at])
  end

  private

  def set_pokemon
    @pokemon = Pokemon.includes(:kinds).find(params[:id])
  end
end
