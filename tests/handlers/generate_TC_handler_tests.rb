require_relative "../test_helper"
require_relative "../../app"
require_rel "../../constants"

describe App do
  describe "Integration Tests" do
    context "Multiple clauses and one section" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template [CLAUSE-1]. [SECTION-1] - [CLAUSE-2]",
        "dataset": {
          "clauses": [
            { "id": 1, "text": "clause1 text"},
            { "id": 2, "text": "clause2 text"}
          ],
          "sections": [{ "id": 1, "clauses_ids": [1, 2]}]
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "this is template clause1 text. clause1 text;clause2 text - clause2 text" }
    end

    context "Multiple clauses and sections" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "[SECTION-2] template [CLAUSE-1]. [SECTION-1] - [CLAUSE-2]",
        "dataset": {
          "clauses": [
            { "id": 1, "text": "clause1"},
            { "id": 2, "text": "clause2"}
          ],
          "sections": [
            { "id": 1, "clauses_ids": [1, 2]},
            { "id": 2, "clauses_ids": [2, 1, 1]}
          ]
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "clause2;clause1;clause1 template clause1. clause1;clause2 - clause2" }
    end

    context "Include tags without dataset" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "[SECTION-2] normal text [CLAUSE-1]."
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "[SECTION-2] normal text [CLAUSE-1]." }
    end

    context "Include clause tag that does not exist in the dataset" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "[SECTION-2] template [CLAUSE-1]. [SECTION-1] - [CLAUSE-2]",
        "dataset": {
          "clauses": [
            { "id": 2, "text": "clause2"}
          ],
          "sections": [
            { "id": 1, "clauses_ids": [1, 2]},
            { "id": 2, "clauses_ids": [2, 1, 1]}
          ]
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "clause2;; template [CLAUSE-1]. ;clause2 - clause2" }
    end

    context "Get request" do
      let(:app) { App }
      let(:response) { get "/" }

      it { expect(response.status).to eq 405 }
      it { expect(response.body).to eq ERRORS[:NOT_ALLOWED_METHOD] }
    end
  end

  describe "Parsing Tests" do
    context "Correct data" do
      let(:app) { App }
      let(:response) {
        post "/", '{
        "template": "this is template [CLAUSE-1]. [SECTION-1]",
        "dataset": {
          "clauses": [{ "id": 1, "text": "clause1 text"}],
          "sections": [{ "id": 1, "clauses_ids": [1]}]
        }
      }'
      }

      it { expect(response.status).to eq 200 }
      it { expect(response.body).to eq "this is template clause1 text. clause1 text" }
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
      it { expect(response.body).to eq "this is template" }
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
      it { expect(response.body).to eq "this is template" }
    end
  end
end
