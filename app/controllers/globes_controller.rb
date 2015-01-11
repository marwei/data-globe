class GlobesController < ApplicationController
  def index
    @globes = Globe.all
  end

  def new
    @globe = Globe.new
  end

  def create
    @globe = Globe.new(globe_params)
    if @globe.save
      redirect_to @globe
    else
      flash[:notice] = "Can't be blank"
      render "new"
    end
  end

  def show
    @globe = Globe.find(params[:id])
    @points_json = Point.get_json @globe.points
  end

  def edit
    
  end

  def update
    
  end

  def delete
    
  end

  private 

    def globe_params
      params.require(:globe).permit(:name, :description)
    end
end
