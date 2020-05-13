RSpec.describe ConsolidatedScreeningList do
  it "has an API version" do
    expect(ConsolidatedScreeningList::API_VERSION).to eql("v1")
  end

  it "has a production URL" do
    expect(ConsolidatedScreeningList::PRODUCTION_URL).to eql("https://api.trade.gov/gateway/v1/consolidated_screening_list/")
  end

  it "has a version number" do
    expect(ConsolidatedScreeningList::VERSION).not_to be nil
  end

  it "returns the user agent" do
    expect(subject.user_agent).to match(/ConsolidatedScreeningList\/\d\.\d\.\d/)
  end
end
