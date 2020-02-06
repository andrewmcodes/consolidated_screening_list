RSpec.describe ConsolidatedScreeningList do
  it "has a version number" do
    expect(ConsolidatedScreeningList::VERSION).not_to be nil
  end

  it "returns the user agent" do
    expect(subject.user_agent).to match(/ConsolidatedScreeningList\/\d\.\d\.\d/)
  end
end
