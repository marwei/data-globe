class PointsController < ApplicationController
  def index
    
  end
  def new
    @point = Point.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @globe = Globe.find(params[:globe_id])
    @point = @globe.points.add_or_build(point_params)
    
    respond_to do |format|
      if @point.save
        @points_json = Point.get_json @globe.points
        format.html
        format.js
      else
        format.html { render 'new' }
        format.js
      end
    end
    
  end

  def edit

  end

  def update
    
  end

  def delete
    
  end


  private

    def point_params
      params.require(:point).permit(:city, :state, :country, :magnitude)
    end
end
