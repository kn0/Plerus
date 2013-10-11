#!/usr/bin/env ruby
$LOAD_PATH.unshift("#{File.dirname(__FILE__)}/lib")
require 'plerus'
require 'psych'

# Provide a banner message that shows how eairly in development this project really is.
puts "Plerus Version 0.0.1"

# Start by creating a global Plerus framework object
framework = Plerus.start_framework

# Load shellcode example
sc =  Psych.load(File.read 'samples/exec_calc.yaml')

# Create a shellcode object.
shellcode = Plerus::Shellcode.new(sc)

# Create a pool
pool = Plerus::Pool.new(framework,shellcode,Plerus::DEFAULT_POOL_SIZE)

# Compile each 'animal' in the pool (right now there is only one compiler)
compiler = framework.random_compiler
pool.each do |animal|
  compiler.compile(animal,'output')  
end
