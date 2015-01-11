class GlobesController < ApplicationController
  def index
    redirect_to "static/index"
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
      render "static/index"
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

  def import
    @globe = Globe.find(params[:id])
    p params
    @globe.points.import(params[:globe][:file])
    redirect_to @globe
  rescue
    redirect_to @globe
  end

  private 

    def globe_params
      params.require(:globe).permit(:name, :description)
    end
end
