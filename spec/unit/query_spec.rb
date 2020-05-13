require "spec_helper"

RSpec.describe ConsolidatedScreeningList::Query do
  let(:api_key) { SecureRandom.uuid }
  subject { ConsolidatedScreeningList::Query.new(params: {q: "smith"}, api_key: api_key) }

  it "raises ArgumentError if api_key is invalid" do
    expect { ConsolidatedScreeningList::Query.new(params: {q: "smith"}, api_key: "foo") }.to raise_error(ArgumentError)
  end

  # it "raises ArgumentError if countries are invalid" do
  #   expect { ConsolidatedScreeningList::Query.new(params: {q: "smith", countries: ["NC"]}, api_key: api_key) }.to raise_error(ArgumentError)
  # end

  it "returns the country list" do
    expect(ConsolidatedScreeningList::Query.countries.count).to eql(249)
    expect(ConsolidatedScreeningList::Query.countries.first).to eql("AF")
  end

  it "builds the endpoint" do
    expected = "https://api.trade.gov/gateway/v1/consolidated_screening_list/search"
    expect(ConsolidatedScreeningList::Query.endpoint).to eql(expected)
  end

  it "accepts params as a hash" do
    expect(subject.instance_variable_get("@params")[:q]).to eql("smith")
  end

  it "accepts params as a string" do
    query = ConsolidatedScreeningList::Query.new(params: "smith", api_key: api_key)
    expect(query.instance_variable_get("@params")[:q]).to eql("smith")
  end

  it "merges the default params" do
    expect(subject.instance_variable_get("@params")[:offset]).to eql(0)
  end

  it "builds the param lists" do
    expect(subject.send(:params)[:countries]).to match(/AF\,AX/)
    expect(subject.send(:params)[:sources]).to match(/CAP\,DPL/)
  end

  it "strips empty params" do
    count = subject.send(:params).count { |k, v| v.nil? }
    expect(count).to eql(0)
  end

  it "calls the API" do
    json = '{"results": [{"foo": "bar"}]}'
    stub = stub_request(:get, /https:\/\/api\.trade\.gov\/gateway\/v1\/consolidated_screening_list\/search.*/)
      .to_return(status: 200, body: json)

    expect(subject.call).to eql(json)
    expect(stub).to have_been_requested
  end
end
