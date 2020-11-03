class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find_by(id: params[:id])

    redirect_to kittens_path if @kitten.blank?

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @kitten }
    end

  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find_by(id: params[:id])

    redirect_to kitten_path if @kitten.blank?

    flash.alert = "Kitten Edited!"
  end

  def create
    @kitten = Kitten.new(kitten_params)
    
    if @kitten.invalid?
      redirect_to new_kitten_path
      flash.alert = "Your kitten's details weren't all filled out! Try again!"
    else
      @kitten.save
      redirect_to kitten_path(@kitten.id)
      flash.alert = "Kitten Created!"
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      redirect_to(@kitten)
    else
      render 'new'
    end
  end

  def destroy
    @kitten = Kitten.find_by(id: params[:id])

    @kitten.destroy

    redirect_to kittens_path

    flash.alert = "Kitten Deleted!"
  end

  private

  def kitten_params
    params.require(:kitten).permit(:id, :name, :age, :cuteness, :softness)
  end

end
