require "spec_helper"

RSpec.describe ConsolidatedScreeningList::Result do
  subject { ConsolidatedScreeningList::Result.new "foo" => "bar" }

  it "stores the data" do
    expect(subject.data["foo"]).to eql("bar")
  end

  it "exposes properties as methods" do
    expect(subject.foo).to eql("bar")
  end
end
