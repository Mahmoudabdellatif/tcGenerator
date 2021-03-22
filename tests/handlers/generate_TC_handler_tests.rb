require_relative "../test_helper"
require_relative "../../app"
require_rel "../../constants"

describe App do
  describe "Parsing Tests" do
    context "Simple test" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template",
        "dataset": {
          "clauses": [{ "id": 1, "text": "clause1 text"}],
          "sections": [{ "id": 1, "clauses_ids": [1]}]
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "T&C Generator" }
    end

    context "Empty Body" do
      let(:app) { App }
      let(:response) {
        post "/", "{}"
      }

      it { expect(response.status).to eq 400 }
      it { expect(response.body).to eq ERRORS[:BAD_REQUEST] + ERRORS[:MISSING_TEMPLATE] }
    end

    context "No dataset" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template"
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "T&C Generator" }
    end

    context "Missing clauses" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template",
        "dataset": {
          "sections": [{ "id": 1, "clauses_ids": [1]}]
        }
      }'
      }

      it { expect(response.status).to eq 400 }
      it { expect(response.body).to eq ERRORS[:BAD_REQUEST] + ERRORS[:MISSING_CLAUSES] }
    end

    context "Empty clauses and sections" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template",
        "dataset": {
          "clauses": [],
          "sections": []
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "T&C Generator" }
    end
  end
end
