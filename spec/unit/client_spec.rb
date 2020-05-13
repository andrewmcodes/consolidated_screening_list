require "spec_helper"

RSpec.describe ConsolidatedScreeningList::Client do
  let(:api_key) { SecureRandom.uuid }
  subject { ConsolidatedScreeningList::Client.new(api_key: api_key) }

  it "accepts an api key" do
    expect(subject.api_key).to eql(api_key)
  end

  # it "defaults to the env API key" do
  #   with_env "TRADE_API_KEY", "00112233-4455-6677-8899-aabbccddeeff" do
  #     expect(subject.api_key).to eql("00112233-4455-6677-8899-aabbccddeeff")
  #   end
  # end

  it "calls the API" do
    stub = stub_request(:get, /https:\/\/api\.trade\.gov\/gateway\/v1\/consolidated_screening_list\/search.*/)
      .to_return(status: 200, body: '{"results": [{"foo": "bar"}, {"foo2": "bar2"}]}')
    search = subject.search q: "smith"
    expect(stub).to have_been_requested
    expect(search.count).to eql(2)
    expect(search.first.class).to eql(ConsolidatedScreeningList::Result)
    expect(search.first.foo).to eql("bar")
  end
end
