require_relative "../test_helper"
require_relative "../../app"

describe App do
  context "get to /" do
    let(:app) { App }
    let(:response) { get "/" }

    it { expect(response.status).to eq 200 }
    it { expect(response.body).to eq "T&C Generator" }
  end
end
