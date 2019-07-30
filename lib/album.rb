class Album
  attr_accessor :name, :album_year, :cost
  attr_reader :id



  def initialize(attributes)
    @name = attributes.fetch(:name)
    # @album_year = attributes.fetch(:album_year) || 1197
    # @cost = attributes.fetch(:cost) || 0
    @id = attributes.fetch(:id)
    (attributes.key? :album_year) ? @album_year = attributes.fetch(:album_year).to_i : @album_year = 1960
   (attributes.key? :cost) ? @cost = attributes.fetch(:cost).to_i : @cost = 10

  # if(attributes.key? :release_year)
  #   @release_year = attributes.fetch(:release_year).to_i
  # else
  #   @release_year = 1960
  # end
  # if(attributes.key? :price)
  #   @cost = attributes.fetch(:price).to_i
  # else
  #   @cost = 10
  # end
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY name;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      cost = album.fetch("cost").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :cost => cost, :id => id}))
    end
    albums
  end

  def self.year
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY ALBUM_YEAR ASC;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      cost = album.fetch("cost").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :cost => cost, :id => id}))
    end
    albums
  end

  def self.high_to_low
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY COST DESC;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      cost = album.fetch("cost").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :cost => cost, :id => id}))
    end
    albums
  end

  def self.low_to_high
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY COST ASC;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      cost = album.fetch("cost").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :cost => cost, :id => id}))
    end
    albums
  end

  def self.random
    album = []
    result = DB.exec("SELECT * FROM albums ORDER BY RANDOM() LIMIT 1;").first
    name = result.fetch("name")
    year = result.fetch("album_year").to_i
    cost = result.fetch("cost").to_i
    id = result.fetch("id").to_i
    album.push(Album.new({:name => name, :album_year => year, :cost => cost, :id => id}))
    return album
  end

  def save
    result = DB.exec("INSERT INTO albums (name, album_year, cost) VALUES ('#{@name}', #{@album_year}, #{@cost}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    DB.exec("DELETE FROM albums *;")
  end

  def self.find(id)
    album = DB.exec("SELECT * FROM albums WHERE id = #{id};").first
    if album
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      cost = album.fetch("cost").to_i
      id = album.fetch("id").to_i
      Album.new({:name => name, :album_year => year, :cost => cost, :id => id})
    else
      nil
    end
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    (attributes.key? :album_year) ? @album_year = attributes.fetch(:album_year).to_i : @album_year = 1960
   (attributes.key? :cost) ? @cost = attributes.fetch(:cost).to_i : @cost = 10
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE albums SET album_year = #{@album_year} WHERE id = #{@id};")
    DB.exec("UPDATE albums SET cost = '#{@cost}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end

  def songs
    Song.find_by_album(self.id)
  end
end
