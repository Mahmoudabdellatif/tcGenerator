require_relative "../test_helper"
require_relative "../../app"

describe App do
  context "get to /" do
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
    # it { expect(response.body).to eq "T&C Generator" }
  end
end
