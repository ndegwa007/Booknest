require 'rails_helper'


# Uses before_action :authenticate_user! in an anonymous controller to test authenticate_user!.
# Mocks a user with FactoryBot (let(:user) { create(:user) }).
# Checks if current_user correctly retrieves or returns nil.
# Ensures unauthorized access redirects to login_path.

RSpec.describe ApplicationController, type: :controller do
  controller do
    before_action :authenticate_user!

    def index
      render plain: "Accessible"
    end
  end

  let(:user) { create(:user) } # using FactoryBot

  describe "#current_user" do
    it "returns the user when session contains a valid user_id" do
      session[:user_id] = user.id
      expect(controller.send(:current_user)).to eq(user)
    end

    it "returns nil when session does not contain a user_id" do
      session[:user_id] = nil
      expect(controller.send(:current_user)).to be_nil
    end
  end

  describe "#authenticate_user!" do
    context "when user is logged in" do
      it "allows access to the action" do
        session[:user_id] = user.id
        get :index
        expect(response.body).to eq("Accessible")
      end
    end

    context "when user is not logged in" do
      it "redirects to the login page" do
        get :index
        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq('You need to log in to access this page.')
      end
    end
  end
end
