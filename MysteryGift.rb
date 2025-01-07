require 'base64'
require 'zlib'

input_file = 'MysteryGift.txt'
output_file = 'Output.txt'

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

def extract_printable_ascii(content)
  content.chars.select { |c| c.match?(/[[:print:]]/) }.join
end

def convert_to_hex(content)
  content.unpack1('H*')
end

decompressed_content = decode_and_decompress(input_file)

File.open(output_file, 'w') do |file|
  file.write(decompressed_content)
end

puts "\nHexadecimal Representation:"
puts convert_to_hex(decompressed_content)

puts "\nPrintable ASCII Characters:"
puts extract_printable_ascii(decompressed_content)

puts "\nDecryption and decompression complete. Output saved to '#{output_file}'."
