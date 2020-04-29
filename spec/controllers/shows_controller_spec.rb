require "rails_helper"

RSpec.describe ShowsController, type: :controller do
  describe "POST #create" do
    subject { -> { post :create, params: { show: show_params } } }

    context "with valid params" do
      let(:show_params) { attributes_for(:show) }

      it { is_expected.to change(Show, :count).by(1) }
    end

    context "with invalid params" do
      let(:show_params) { { title: "" } }

      it { is_expected.not_to change(Show, :count) }
    end
  end

  describe "DELETE #destroy" do
    let!(:show) { create(:show) }
    subject { -> { delete :destroy, params: { id: show_id } } }

    context "with valid id" do
      let(:show_id) { show.id }

      it { is_expected.to change(Show, :count).by(-1) }
    end

    context "with invalid id" do
      let(:show_id) { -1 }

      it { is_expected.not_to change(Show, :count) }
    end
  end
end
