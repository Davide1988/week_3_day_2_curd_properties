require('pg')


class Property

  attr_reader :id
  attr_accessor :address, :value, :number_of_bedrooms, :buy_let_status

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @buy_let_status = options['buy_let_status']
  end


  def save
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "INSERT INTO properties
           (address, value, number_of_bedrooms, buy_let_status)
           VALUES ($1, $2, $3, $4)
           RETURNING *"
    values = [@address, @value, @number_of_bedrooms, @buy_let_status]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]['id'].to_i

    db.close()
  end

  def Property.delete_all
      db = PG.connect({dbname: 'properties', host: 'localhost'})
      sql = "DELETE FROM properties"
      db.prepare("smash", sql)
      db.exec_prepared("smash")
      db.close
  end

  def Property.show_all
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("show_all", sql)
    all_properties = db.exec_prepared("show_all")
    db.close()
    return all_properties.map{|property| Property.new(property)}
  end

  def delete_one
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    value = [@id]
    db.prepare("delete_single",sql)
    db.exec_prepared("delete_single",value)
    db.close
  end

  def Property.find(id)
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "SELECT FROM properties WHERE id = $1"
    value = [id]
    db.prepare("find", sql)
    binding.pry
    house = db.exec_prepared("find", value)
    db.close
    return Property.new(house)


  end

  def update
    db = PG.connect({dbname: 'properties', host: 'localhost'})
    sql = "UPDATE properties
          SET (address, value, number_of_bedrooms, buy_let_status) =
          ($1, $2, $3, $4)
          WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @buy_let_status, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end



end
