RSpec.describe ParallelRspecProgress do
  5.times do
    it "does something useful" do
      sleep(0.2)
      expect(true).to eq(false)
    end
  end
end
