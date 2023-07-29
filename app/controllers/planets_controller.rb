class PlanetsController < ApplicationController
  before_action :set_planet, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity


  # GET /planets
  def index
    planets = Planet.all
    render json: planets, status: :ok
  end

  def show
    planet = Planet.find(params[id])
    render json: planet, status: :ok
  end


  def create
    planet = Planet.create!(planet_params)
    render json: planet, status: :created
  end

  def destroy
    planet = Planet.find(params[id])
    planet.destroy
    head :no_content
  end

  def update
    planet = Planet.find(params[id])
    planet.update!(planet_params)
    render json: planet, status: :accepted
  end

  private

  def render_not_found_response
    render json: { error: "Author not found" }, status: :not_found
  end

  def render_unprocessable_entity(invalid)
    render json: {error: invalid.record.errors}, status: :unprocessable_entity
  end

  def planet_params
    params.permit(:name, :distance_from_earth, :nearest_star, :image)
  end
end
