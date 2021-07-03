class Api::V1::KindsController < ApplicationController
  before_action :set_kind, only: :show

  def index
    @kinds = Kind.all
    render json: @kinds.as_json(only: %i[id name])
  end

  def show
    render json: @kind.as_json(only: %i[id name])
  end

  private

  def set_kind
    @kind = Kind.find(params[:id])
  end
end
