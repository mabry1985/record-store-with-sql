class Album
  attr_accessor :name
  attr_reader :id, :album_year



  def initialize(attributes)
    @name = attributes.fetch(:name)
    @album_year = attributes.fetch(:album_year) || 1197
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY name;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :id => id}))
    end
    albums
  end

  def self.year
    returned_albums = DB.exec("SELECT * FROM albums ORDER BY album_year::int;")
    albums = []
    returned_albums.each() do |album|
      name = album.fetch("name")
      year = album.fetch("album_year").to_i
      id = album.fetch("id").to_i
      albums.push(Album.new({:name => name, :album_year => year, :id => id}))
    end
    albums
  end

  def save
    result = DB.exec("INSERT INTO albums (name, album_year) VALUES ('#{@name}', #{@album_year}) RETURNING id;")
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
      id = album.fetch("id").to_i
      Album.new({:name => name, :album_year => year, :id => id})
    else
      nil
    end
  end

  def update(name, year)
    @name = name
    @album_year = year
    DB.exec("UPDATE albums SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE albums SET album_year = '#{@album_year}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM albums WHERE id = #{@id};")
    DB.exec("DELETE FROM songs WHERE album_id = #{@id};")
  end

  def songs
    Song.find_by_album(self.id)
  end
end
