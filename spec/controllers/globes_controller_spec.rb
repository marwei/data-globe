require 'rails_helper'

RSpec.describe GlobesController, type: :controller do
  describe "GET #index" do
    it "redirects to root_path" do
      get :index
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET #new" do
    before { get :new }
    it "instantiates new globe instance" do
      expect(assigns(:globe)).to be_a_kind_of(Globe)
    end
    it "renders the new template" do
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      before { post :create, globe: { name: "name", description: "desc" } }
      it "creates new globe" do
        expect(Globe.count).to eq(1)
      end
      it "redirects to new globe page" do
        expect(response).to redirect_to(assigns(:globe))
      end
    end
    context "with invalid params" do
      before { post :create, globe: { description: "desc" } }
      it "doesn't create new globe" do
        expect(Globe.count).to eq(0)
      end
      it "redirects to root with notice" do
        expect(response).to redirect_to(root_url)
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe "GET #show" do
    let(:globe) { create(:globe_with_points, points_count: 10) }
    before { get :show, id: globe.id }
    it "renders the show template" do
      expect(response).to render_template("show")
    end
    it "finds the globe" do
      expect(assigns(:globe)).to eq(globe)
    end
    it "gets all globe's data point in json" do
      expect(assigns(:points_json).size).to eq(30)
    end
  end

  describe "GET #edit" do
    let(:globe) { create(:globe) }
    before { get :edit, id: globe.id }
    it "retrieves the to-be-edited globe instance" do
      expect(assigns(:globe)).to eq(globe)
    end
    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end
  describe "POST #update" do
    let(:globe) { create(:globe) }
    context "with valid params" do
      before do
        post :update, id: globe.id, globe: { name: "Updated Globe" }
        globe.reload
      end
      it "updates globe" do
        expect(globe.name).to eq("Updated Globe")
      end
      it "redirects to #show globe" do
        expect(response).to redirect_to(globe)
      end
    end
    context "with invalid params" do
      before do
        @before_name = globe.name
        post :update, id: globe.id, globe: { name: nil }
        globe.reload
      end
      it "does not update globe" do
        expect(globe.name).to eq(@before_name)
      end
      it "renders #edit globe" do
        expect(response).to render_template("edit")
      end
    end
  end
  describe "POST #destroy" do
    let(:globe) { create(:globe_with_points, points_count: 10) }
    before do
      post :destroy, id: globe.id
    end
    it "removes globe" do
      expect(Globe.count).to eq(0)
    end
    it "removes all data associated with the globe" do
      expect(Point.count).to eq(0)
    end
    it "redirects to root with notice" do
      expect(response).to redirect_to(root_url)
      expect(flash[:notice]).to be_present
    end
  end
end
