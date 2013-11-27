require "spec_helper"

describe WorkshopAttendancesController  , :type => :routing do

  describe "routing" do

    it "routes to #index" do
      get("/workshop_attendances").should route_to("workshop_attendances#index")
    end

    it "routes to #new" do
      get("/workshop_attendances/new").should route_to("workshop_attendances#new")
    end

    it "routes to #show" do
      get("/workshop_attendances/1").should route_to("workshop_attendances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workshop_attendances/1/edit").should route_to("workshop_attendances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workshop_attendances").should route_to("workshop_attendances#create")
    end

    it "routes to #update" do
      put("/workshop_attendances/1").should route_to("workshop_attendances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workshop_attendances/1").should route_to("workshop_attendances#destroy", :id => "1")
    end

  end
end
