require('spec_helper')

describe '#Artist' do
  before(:each) do
    @album = Album.new({:name => "Giant Steps", :id => nil})
    @album.save()
    @song = Song.new({:name => "All eyes on me", :id => nil, :album_id => @album.id})
  end

  describe('.all') do
    it("returns an empty array when there are no artists") do
      expect(Artist.all).to(eq([]))
    end
  end
  #
  describe('#save') do
    it("saves an artist") do
      artist = Artist.new({:name => "Tupac", :id => nil, :album_id => 1, :song_id => 1})
      artist.save()
      artist2 = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      artist2.save()
      expect(Artist.all).to(eq([artist, artist2]))
    end
  end
  #
  describe('.clear') do
    it("clears all artists") do
      artist = Artist.new({:name => "Tupac", :id => nil, :album_id => 1, :song_id => 1})
      artist.save()
      artist2 = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      artist2.save()
      Artist.clear
      expect(Artist.all).to(eq([]))
    end
  end
  #
  describe('#==') do
    it("is the same artist if it has the same attributes as another artist") do
      artist = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      artist2 = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      expect(artist).to(eq(artist2))
    end
  end

  describe('.find') do
    it("finds an artist by id") do
      artist = Artist.new({:name => "Tupac", :id => nil, :album_id => 1, :song_id => 1})
      artist.save()
      artist2 = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      artist2.save()
      expect(Artist.find(artist.id)).to(eq(artist))
    end
  end
  #
  describe('#update') do
    it("updates an artist by id") do
      artist = Artist.new({:name => "Tupac", :id => nil, :album_id => 1, :song_id => 1})
      artist.save()
      artist.update("Tupac")
      expect(artist.name).to(eq("Tupac"))
    end
  end

  describe('#delete') do
    it("deletes an artist by id") do
      artist = Artist.new({:name => "Tupac", :id => nil, :album_id => 1, :song_id => 1})
      artist.save()
      artist2 = Artist.new({:name => "Bilbo Baggins", :id => nil, :album_id => 1, :song_id => 1})
      artist2.save()
      artist.delete()
      expect(Artist.all).to(eq([artist2]))
    end
  end

  # describe('#songs') do
  #   it("returns an artist's songs") do
  #     artist = Artist.new({:name => "Tupac", :id => nil})
  #     artist.save()
  #     song = Song.new({:name => "Naima", :artist_id => artist.id, :id => nil})
  #     song.save()
  #     song2 = Song.new({:name => "Cousin Mary", :artist_id => artist.id, :id => nil})
  #     song2.save()
  #     expect(artist.songs).to(eq([song, song2]))
  #   end
  # end
end
