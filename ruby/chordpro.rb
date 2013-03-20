# Script to generate chord definitions from the chordpro format

require 'rubygems'
require 'facets/integer/ordinal'
Finger = Struct.new(:fret, :string)
Chord = Struct.new(:name, :bar, :fingers)


def write_chord(chord)
puts "\\chord{#{chord.name.gsub("#", "S")}}{"
offset = 0
if chord.bar == 1 or chord.bar == 2 then
  puts "\\bar 4 #{chord.bar} {}"
  offset = 0
end
if chord.bar > 2 then
  puts "\\bar 4 1 {#{chord.bar.ordinalize} fret}"
  offset = chord.bar - 1
end
chord.fingers.each do |f|
  puts "\\single #{f.string} #{f.fret - offset}"
end
puts "}"
end


def parse_chord(s)
  m = /\{define: ([^ ]*) base-fret ([0-9]*) frets ([0-9]*) ([0-9]*) ([0-9]*) ([0-9]*).*/.match(s)
  if !m then 
    return nil
  end
  name = m[1].to_s
  base = m[2].to_i
  f4 = m[3].to_i
  f3 = m[4].to_i
  f2 = m[5].to_i
  f1 = m[6].to_i

  c = Chord.new
  c.name = name
  c.bar = 0
  c.bar = base + 1 if base > 1
  show_above = base > 0? 1 : 0

  c.fingers = []
  c.fingers << Finger.new(f1 + base, 1) if f1 > show_above
  c.fingers << Finger.new(f2 + base, 2) if f2 > show_above
  c.fingers << Finger.new(f3 + base, 3) if f3 > show_above
  c.fingers << Finger.new(f4 + base, 4) if f4 > show_above
  return c
end

ARGF.each do |line|
  c = parse_chord(line)
  write_chord(c) if c
end
