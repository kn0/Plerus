require 'plerus/constants'
require 'plerus/framework'
require 'plerus/shellcode'
require 'plerus/pool'
require 'plerus/evo/mutagen'
require 'plerus/evo/compiler'
require 'plerus/fitness'

module Plerus
  def self.start_framework
    evos_path = File.expand_path(File.join(File.dirname(__FILE__),"/../evo"))
    return Plerus::Framework.new(evos_path)
  end
end
