RSpec.describe ParallelRspecProgress do
  it "has a version number" do
    expect(ParallelRspecProgress::VERSION).not_to be nil
  end

  10.times do
    it "does something useful" do
      sleep(0.2)
      expect(true).to eq(true)
    end
  end
end
