require 'rails_helper'

RSpec.describe HomeController,type: :controller do
  describe "Get home index" do

    before :each do
      apparel_consultant = FactoryGirl.create(:apparel_consultant)
      login_as(apparel_consultant,scope: :apparel_consultant)
    end

    it "should have current apparel consultant" do
      subject.current_apparel_consultant.should_not be_nil
    end
  end
end
