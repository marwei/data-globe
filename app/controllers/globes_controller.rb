class GlobesController < ApplicationController
  before_action -> { @globe = Globe.find(params[:id]) }, except: [:index, :new, :create]
  def index
    redirect_to root_path
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
      redirect_to root_path
    end
  end

  def show
    @points_json = Point.get_json @globe.points
  end

  def edit
  end

  def update
    if @globe.update(globe_params)
      redirect_to @globe
    else
      render 'edit'
    end
  end

  def destroy
    @globe.destroy
    flash[:notice] = "Globe #{@globe.name} destroyed"
    redirect_to root_path
  end

  def import
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
