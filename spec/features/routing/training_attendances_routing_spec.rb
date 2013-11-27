require "spec_helper"

describe TrainingAttendancesController  , :type => :routing do

  describe "routing" do

    it "routes to #index" do
      get("/training_attendances").should route_to("training_attendances#index")
    end

    it "routes to #new" do
      get("/training_attendances/new").should route_to("training_attendances#new")
    end

    it "routes to #show" do
      get("/training_attendances/1").should route_to("training_attendances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/training_attendances/1/edit").should route_to("training_attendances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/training_attendances").should route_to("training_attendances#create")
    end

    it "routes to #update" do
      put("/training_attendances/1").should route_to("training_attendances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/training_attendances/1").should route_to("training_attendances#destroy", :id => "1")
    end

  end
end
