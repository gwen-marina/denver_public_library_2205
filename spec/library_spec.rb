require './lib/library'
require './lib/author'

RSpec.describe Library do

  let(:dpl) { Library.new("Denver Public Library") }
  let(:charlotte_bronte) { Author.new({first_name: "Charlotte", last_name: "Bronte"}) }
  let(:harper_lee) { Author.new({first_name: "Harper", last_name: "Lee"}) }

  it "exists" do
    expect(dpl).to be_a(Library)
  end

  it "has attributes" do
    expect(dpl.name).to eq("Denver Public Library")
    expect(dpl.books).to eq([])
    expect(dpl.authors).to eq([])
  end

  it "can add authors and return an array" do
    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    expect(dpl.authors).to eq([charlotte_bronte, harper_lee])
  end

  it "can return an array of books" do
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    expect(dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
  end

  it "can return a publication time frame hash for an author with the years of their first and last book" do
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    expect(dpl.publication_time_frame_for(charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
    expect(dpl.publication_time_frame_for(harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end

  it "can return true/false if a book doesn't exist or has been checked out or not" do
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    expect(dpl.checkout(mockingbird)).to eq(false)
    expect(dpl.checkout(jane_eyre)).to eq(false)

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    expect(dpl.checkout(jane_eyre)).to eq(true)
  end
end
