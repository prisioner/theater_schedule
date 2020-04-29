require "rails_helper"
require "rspec_api_documentation/dsl"

resource "Shows" do
  let!(:actual_shows) { create_list(:show, 2) }
  let!(:past_show) { create(:show, start_date: 1.month.ago, end_date: 7.days.ago) }
  let(:parsed_response_body) { JSON.parse(response_body, symbolize_names: true) }

  explanation "Shows resource"

  header "Content-Type", "application/json"

  get "/shows" do
    let(:expected_response) { actual_shows.map { |s| ShowSerializer.new(s) } }

    context "200" do
      example_request "Getting a list of shows" do
        expect(status).to eq(200)
        expect(response_body).to eq(expected_response.to_json)
      end
    end
  end

  delete "/shows/:id" do
    context "200" do
      let(:id) { past_show.id }

      example_request "Deleting a show" do
        expect(status).to eq(200)
        expect(parsed_response_body).to eq({ success: "ok" })
      end
    end

    context "404" do
      let(:id) { -1 }

      example_request "Delete - Invalid `id` request" do
        expect(status).to eq(404)
        expect(parsed_response_body).to eq({ errors: "not found" })
      end
    end
  end

  post "/shows", type: :json do
    with_options scope: :show, with_example: true do
      parameter :title, "Show title", required: true
      parameter :start_date, "Show start date, YYYY-MM-DD", required: true
      parameter :end_date, "Show end date, YYYY-MM-DD", required: true
    end

    context "200" do
      let(:title) { "Le nozze di Figaro ossia la folle giornata" }
      let(:start_date) { "2020-09-01" }
      let(:end_date) { "2020-09-30" }

      let(:raw_post) { params.to_json }

      let(:expected_response) do
        {
          title: "Le nozze di Figaro ossia la folle giornata",
          start_date: "2020-09-01",
          end_date: "2020-09-30",
        }
      end

      example_request "Create a show" do
        expect(status).to eq(200)
        expect(parsed_response_body.slice(:title, :start_date, :end_date)).to eq(expected_response)
      end
    end

    context "422" do
      let(:title) { "" }
      let(:raw_post) { params.to_json }

      example_request "Create - Invalid params" do
        expect(status).to eq(422)
        expect(parsed_response_body).to include(:errors)
      end
    end

    context "400" do
      example_request "Create - Invalid request" do
        expect(status).to eq(400)
        expect(parsed_response_body).to eq({ errors: "bad request" })
      end
    end
  end
end
