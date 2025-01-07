require 'base64'
require 'zlib'

# Read the input file
input_file = 'MysteryGift.txt'
output_file = 'Output.txt'

# Decode base64 and attempt decompression
def decode_and_decompress(input_file)
  encoded_content = File.read(input_file)
  decoded_content = Base64.decode64(encoded_content)

  begin
    decompressed_content = Zlib::Inflate.inflate(decoded_content)
  rescue Zlib::DataError
    decompressed_content = decoded_content
  end

  decompressed_content
end

# Extract printable ASCII characters from decompressed content
def extract_printable_ascii(content)
  content.chars.select { |c| c.match?(/[[:print:]]/) }.join
end

# Convert binary data to hexadecimal format
def convert_to_hex(content)
  content.unpack1('H*')
end

# Main program flow
decompressed_content = decode_and_decompress(input_file)

# Write the decompressed content to the output file
File.open(output_file, 'w') do |file|
  file.write(decompressed_content)
end

# Output hex representation and printable ASCII to the console
puts "\nHexadecimal Representation:"
puts convert_to_hex(decompressed_content)

puts "\nPrintable ASCII Characters:"
puts extract_printable_ascii(decompressed_content)

puts "\nDecryption and decompression complete. Output saved to '#{output_file}'."
