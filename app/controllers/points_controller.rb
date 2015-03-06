class PointsController < ApplicationController
  before_action :find_globe_and_point, except: :create
  def create
    @globe = Globe.find(params[:globe_id])
    @point = @globe.points.add_or_build(point_params)
    
    respond_to do |format|
      if @point.save
        @points_json = Point.get_json @globe.points
        format.html { redirect_to @globe }
        format.js
      else
        format.html do 
          flash[:error] = "Can't create point, please check your input"
          redirect_to @globe
        end
        format.js
      end
    end
    
  end

  def edit

  end

  def update
    unless @point.update(point_params)
      flash[:error] = "Can't edit point, please check your input"
    end
    redirect_to @globe
  end

  def delete
    
  end


  private

    def point_params
      params.require(:point).permit(:city, :state, :country, :magnitude)
    end

    def find_globe_and_point
      @globe = Globe.find(params[:globe_id])
      @point = @globe.points.find(params[:id])
    end
end
