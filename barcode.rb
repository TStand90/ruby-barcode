require 'chunky_png'

class Code39
  CODE39 = {
    0 => '101001101101', 1 => '110100101011', 2 => '101100101011',
    3 => '110110010101', 4 => '101001101011', 5 => '110100110101',
    6 => '101100110101', 7 => '101001011011', 8 => '110100101101',
    9 => '101100101101', 'A' => '110101001011', 'B' => '101101001011',
    'C' => '110110100101', 'D' => '101011001011', 'E' => '110101100101',
    'F' => '101101100101', 'G' => '101010011011', 'H' => '110101001101',
    'I' => '101101001101', 'J' => '101011001101', 'K' => '110101010011',
    'L' => '101101010011', 'M' => '110110101001', 'N' => '101011010011',
    'O' => '110101101001', 'P' => '101101101001', 'Q' => '101010110011',
    'R' => '110101011001', 'S' => '101101011001', 'T' => '101011011001',
    'U' => '110010101011', 'V' => '100110101011', 'W' => '110011010101',
    'X' => '100101101011', 'Y' => '110010110101', 'Z' => '100110110101',
    '-' => '100101011011', '.' => '110010101101', ' ' => '100110101101',
    '$' => '100100100101', '/' => '100100101001', '+' => '100101001001',
    '%' => '101001001001', '*' => '100101101101'
  }

  def encode(barcode_string)
    encoded_string = '100101101101'			# Start code
    barcode_string.each_char do |s|
  	  encoded_string += CODE39[s.upcase]
    end
    encoded_string += '100101101101'		# End code
    encoded_string
  end

  def decode(barcode_string)
  	decoded_string = ''
    barcode_string.scan(/.{12}/).each do |s|
  	  decoded_string += CODE39.invert[s]
    end
    decoded_string
  end

  def draw(width, height, barcode_string, ratio=2, border=5)
    encoded_string = encode(barcode_string)

    if ratio == 2
      size = (border * 2) + encoded_string.size + (encoded_string.size / 12)
    end

    puts encoded_string.size
    puts size

    image = ChunkyPNG::Image.new(size, height, ChunkyPNG::Color::WHITE)
    x = border

    # This will only work for ratio 2!
    encoded_string.scan(/.{12}/).each do |character|
      character.scan(/.{2}/).each do |bit|
        if bit == '01'
          (0..height-1).each do |y|
            image[x + 1, y] = ChunkyPNG::Color::BLACK
          end
        elsif bit == '10'
          (0..height-1).each do |y|
            image[x, y] = ChunkyPNG::Color::BLACK
          end
        elsif bit == '11'
          (0..height-1).each do |y|
            image[x, y] = ChunkyPNG::Color::BLACK
            image[x + 1, y] = ChunkyPNG::Color::BLACK
          end
        end
        x += 2
      end
      x += 1
    end
    image.save('barcode.png')
  end
end

class Code128
  CODE128 = {
    0 => '11011001100', 1 => '11001101100', 2 => '11001100110',
    3 => '10010011000', 4 => '10010001100', 5 => '10001001100',
    6 => '10011001000', 7 => '10011000100', 8 => '10001100100',
    9 => '11001001000', 10 => '11001000100', 11 => '11000100100',
    12 => '10110011100', 13 => '10011011100', 14 => '10011001110',
    15 => '10111001100', 16 => '10011101100', 17 => '10011100110',
    18 => '11001110010', 19 => '11001011100', 20 => '11001001110',
    21 => '11011100100', 22 => '11001110100', 23 => '11101101110',
    24 => '11101001100', 25 => '11100101100', 26 => '11100100110',
    27 => '11101100100', 28 => '11100110100', 29 => '11100110010',
    30 => '11011011000', 31 => '11011000110', 32 => '11000110110',
    33 => '10100011000', 34 => '10001011000', 35 => '10001000110',
    36 => '10110001000', 37 => '10001101000', 38 => '10001100010',
    39 => '11010001000', 40 => '11000101000', 41 => '11000100010',
    42 => '10110111000', 43 => '10110001110', 44 => '10001101110',
    45 => '10111011000', 46 => '10111000110', 47 => '10001110110',
    48 => '11101110110', 49 => '11010001110', 50 => '11000101110',
    51 => '11011101000', 52 => '11011100010', 53 => '11011101110',
    54 => '11101011000', 55 => '11101000110', 56 => '11100010110',
    57 => '11101101000', 58 => '11101100010', 59 => '11100011010',
    60 => '11101111010', 61 => '11001000010', 62 => '11110001010',
    63 => '10100110000', 64 => '10100001100', 65 => '10010110000',
    66 => '10010000110', 67 => '10000101100', 68 => '10000100110',
    69 => '10110010000', 70 => '10110000100', 71 => '10011010000',
    72 => '10011000010', 73 => '10000110100', 74 => '10000110010',
    75 => '11000010010', 76 => '11001010000', 77 => '11110111010',
    78 => '11000010100', 79 => '10001111010', 80 => '10100111100',
    81 => '10010111100', 82 => '10010011110', 83 => '10111100100',
    84 => '10011110100', 85 => '10011110010', 86 => '11110100100',
    87 => '11110010100', 88 => '11110010010', 89 => '11011011110',
    90 => '11011110110', 91 => '11110110110', 92 => '10101111000',
    93 => '10100011110', 94 => '10001011110', 95 => '10111101000',
    96 => '10111100010', 97 => '11110101000', 98 => '11110100010',
    99 => '10111011110', 100 => '10111101110', 101 => '11101011110',
    102 => '11110101110', 103 => '11010000100', 104 => '11010010000',
    105 => '11010011100', 106 => '1100011101011'
  }
  
  MAP_B = {
    ' ' => 0, '!' => 1, '"' => 2, '#' => 3, '$' => 4, '%' => 5, '&' => 6,
    "'" => 7, '(' => 8, ')' => 9, '*' => 10, '+' => 11, ',' => 12, '-' => 13,
    '.' => 14, '/' => 15, '0' => 16, '1' => 17, '2' => 18, '3' => 19,
    '4' => 20, '5' => 21, '6' => 22, '7' => 23, '8' => 24, '9' => 25,
    ':' => 26, ';' => 27, '<' => 28, '=' => 29, '>' => 30, '?' => 31,
    '@' => 32, 'A' => 33, 'B' => 34, 'C' => 35, 'D' => 36, 'E' => 37,
    'F' => 38, 'G' => 39, 'H' => 40, 'I' => 41, 'J' => 42, 'K' => 43,
    'L' => 44, 'M' => 45, 'N' => 46, 'O' => 47, 'P' => 48, 'Q' => 49,
    'R' => 50, 'S' => 51, 'T' => 52, 'U' => 53, 'V' => 54, 'W' => 55,
    'X' => 56, 'Y' => 57, 'Z' => 58, '[' => 59, '\\' => 60, ']' => 61,
    '^' => 62, '_' => 63, '`' => 64, 'a' => 65, 'b' => 66, 'c' => 67,
    'd' => 68, 'e' => 69, 'f' => 70, 'g' => 71, 'h' => 72, 'i' => 73,
    'j' => 74, 'k' => 75, 'l' => 76, 'm' => 77, 'n' => 78, 'o' => 79,
    'p' => 80, 'q' => 81, 'r' => 82, 's' => 83, 't' => 84, 'u' => 85,
    'v' => 86, 'w' => 87, 'x' => 88, 'y' => 89, 'z' => 90, '{' => 91,
    '|' => 92, '}' => 93, '~' => 94
  }

  def initialize(data_string, height=150, ratio=2, border=10)
    @data = encode(data_string)
    @height = height
    @ratio = ratio
    @border = border
    @image = draw
  end

  def encode(barcode_string)
    x = 1
    checksum = 104
    encoded_string = CODE128[104]     # Start code
    barcode_string.each_char do |s|
      encoded_string += CODE128[MAP_B[s]]
      checksum += (MAP_B[s] * x)
      x += 1
    end
    puts checksum % 103
    encoded_string += CODE128[checksum % 103]
    encoded_string += CODE128[106]    # End code
    encoded_string
  end

  def decode(barcode_string)
    decoded_string = ''
    barcode_string.each_char do |s|
      decoded_string += CODE128.invert[s]
    end
    decoded_string
  end
=begin
  def draw(height, barcode_string, border=10)
    encoded_string = encode(barcode_string)

    width = (border * 2) + encoded_string.size

    image = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)
    x = border

    encoded_string.each_char do |character|
      if character == '1'
        (0..height-1).each do |y|
          image[x, y] = ChunkyPNG::Color::BLACK
        end
      end
      x += 1
    end
    image.save('barcode128.png')
  end
=end

  def draw
    width = (@border * 2) + (@data.size * @ratio)

    image = ChunkyPNG::Image.new(width, @height, ChunkyPNG::Color::WHITE)
    x = @border

    @data.each_char do |character|
      if character == '1'
        (0..@height-1).each do |y|
          (0...@ratio).each do |r|
            image[x + r, y] = ChunkyPNG::Color::BLACK
          end
        end
      end
      x += @ratio
    end
    return image
  end

  def save(file_name)
    @image.save(file_name)
  end

  def draw_ratio(height, barcode_string, ratio=3, border=20)
    encoded_string = encode(barcode_string)

    width = (border * 2) + (encoded_string.size * ratio)

    image = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::WHITE)
    x = border

    encoded_string.each_char do |character|
      if character == '1'
        (0..height-1).each do |y|
          (0...ratio).each do |r|
            image[x + r, y] = ChunkyPNG::Color::BLACK
          end
        end
      end
      x += ratio
    end
    image.save('barcode128.png')
  end
end

class Ean13
  LEFT_ODD = {
    0 => '0001101', 1 => '0011001', 2 => '0010011', 3 => '0111101',
    4 => '0100011', 5 => '0110001', 6 => '0101111', 7 => '0111011',
    8 => '0110111', 9 => '0001011'
  }
  LEFT_EVEN = {
    0 => '0100111', 1 => '0110011', 2 => '0110011', 3 => '0100001',
    4 => '0011101', 5 => '0111001', 6 => '0000101', 7 => '0010001',
    8 => '0001001', 9 => '0010111'
  }
  RIGHT = {
    0 => '1110010', 1 => '1100110', 2 => '1101100', 3 => '1000010',
    4 => '1011100', 5 => '1001110', 6 => '1010000', 7 => '1000100',
    8 => '1001000', 9 => '1110100'
  }
end