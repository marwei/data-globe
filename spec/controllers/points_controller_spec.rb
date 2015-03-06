require 'rails_helper'

RSpec.describe PointsController, type: :controller do
  let(:globe) { create(:globe) }
  describe "POST #create" do
    context "with valid params" do
      before do
        post :create, globe_id: globe.id, point: point_params_full
        globe.reload
      end
      it "creates new point instance for current globe" do
        expect(globe.points.count).to eq(1)
      end
      it "redirects to globe #show" do
        expect(response).to redirect_to(globe)
      end
    end
    context "with invalid params" do
      it "does not create new point instance without params[:state]" do
        post :create, globe_id: globe.id, point: point_params_without(:state)
        expect(globe.reload.points.count).to eq(0)
      end
      it "does not create new point instance without params[:country]" do
        post :create, globe_id: globe.id, point: point_params_without(:country)
        expect(globe.reload.points.count).to eq(0)
      end
      it "redirects to globe #show with notice" do
        post :create, globe_id: globe.id, point: point_params_without(:state)
        expect(response).to redirect_to(globe)
        expect(flash[:error]).to be_present
      end
    end
  end

  describe "GET #edit" do
    before do
      post :create, globe_id: globe.id, point: point_params_full
      get :edit, globe_id: globe.id, id: globe.points.first.id
    end
    it "retrieves the to-be-edited point instance" do
      expect(assigns[:point]).to eq(globe.points.first)
    end
  end

  describe "POST #update" do
    before { post :create, globe_id: globe.id, point: point_params_full }
    context "with valid params" do
      let(:point) { globe.points.first }
      before do
        post :update, globe_id: globe.id, id: point.id, point: point_params_update(:city, 'Los Angeles')
        point.reload
      end
      it "updates the point instance" do
        expect(point.city).to eq("Los Angeles")
      end
    end
    context "with invalid params" do
      let(:point) { globe.points.first }
      before do
        post :update, globe_id: globe.id, id: point.id, point: point_params_update(:state, nil)
        point.reload
      end
      it "doesn't update the point instance" do
        expect(point.state).to eq(point_state)
      end
      it "displays error message" do
        expect(flash[:error]).to be_present
      end
    end
  end
end
