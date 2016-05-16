class CharactersController < ApplicationController
  check_authorization

  def index
    authorize! :index, Character
    @chars = ViewAllCharacters.obtain(current_ability, params)
    render
  end

  def show
    @char = Character.find(params[:id].to_i)
    authorize! :show, @char
    render
  end

  def create
    authorize! :create, Character
    char = Character.new(character_params)
    char.user_id = current_user.id
    if char.save
      render json: {id: char.id}, status: :created
    else
      render json: {errors: char.errors.full_messages}.to_json, status: 400
    end
  end

  def update
    char = Character.find(params[:id].to_i)
    authorize! :update, char
    char.assign_attributes(character_params)
    if char.save
      head :ok
    else
      render json: {errors: char.errors.full_messages}.to_json, status: 400
    end
  end

  def destroy
    char = Character.find(params[:id].to_i)
    authorize! :destroy, char
    char.destroy
    head :no_content
  end

  private

  def character_params
    params.require(:character).permit(:name, :health, :strength)
  end
end
