require "spec_helper"

describe FohsController do
  describe "routing" do

    it "routes to #index" do
      get("/fohs").should route_to("fohs#index")
    end

    it "routes to #new" do
      get("/fohs/new").should route_to("fohs#new")
    end

    it "routes to #show" do
      get("/fohs/1").should route_to("fohs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fohs/1/edit").should route_to("fohs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fohs").should route_to("fohs#create")
    end

    it "routes to #update" do
      put("/fohs/1").should route_to("fohs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fohs/1").should route_to("fohs#destroy", :id => "1")
    end

  end
end
