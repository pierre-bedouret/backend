require_relative 'data/database'

# Get all the data from the json
# all datas are already conveerted in car object and rental object
file_path = File.join(__dir__, '/data/input.json')
database = Database.new(file_path)

# define the output method
def output_json(data)
  file_path_output = File.join(__dir__, 'data/output.json')
  File.open(file_path_output, 'wb') do |file|
    file.write(JSON.generate(data))
  end

  p 'data extracted and putted in a json file'
end

# Get the expected data for all the rentals
rentals_data = { rentals: database.rentals.map(&:extract_data_with_actor) }

# set the output hash in a json file
output_json(rentals_data)
