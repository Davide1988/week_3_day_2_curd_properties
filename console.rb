require('pry')
require_relative('models/property')

Property.delete_all

property_1 = Property.new({ "address" => "123 mystreet",
                            "value" => "120000",
                            "number_of_bedrooms" => "2",
                            "buy_let_status" => "sold"
  })


property_2 = Property.new({   "address" => "321 yourstreet",
                              "value" => "240000",
                              "number_of_bedrooms" => "1",
                              "buy_let_status" => "vacant"
    })

property_1.save
property_2.save

# property_1.delete_one

property_2.value = '200000'
property_2.update

# p Property.show_all

p Property.find(56)
