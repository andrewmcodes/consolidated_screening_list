require "spec_helper"

RSpec.describe ConsolidatedScreeningList::Source do
  subject { ConsolidatedScreeningList::Source.all.first }

  it "returns all sources" do
    expect(ConsolidatedScreeningList::Source.all.count).to eql(12)
  end

  it "returns a source by key" do
    source = ConsolidatedScreeningList::Source.find_by_key(subject.key)
    expect(source.key).to eql(subject.key)
  end

  it "returns a source by name" do
    source = ConsolidatedScreeningList::Source.find_by_name(subject.name)
    expect(source.name).to eql(subject.name)
  end

  it "returns the keys" do
    expect(ConsolidatedScreeningList::Source.keys.count).to eql(12)
    expect(ConsolidatedScreeningList::Source.keys.first).to eql(subject.key)
  end

  it "returns the key" do
    expect(subject.key).to eql("CAP")
  end

  it "returns the name" do
    expect(subject.name).to eql("Correspondent Account or Payable-Through Account Sanctions (CAPTA)")
  end
end
