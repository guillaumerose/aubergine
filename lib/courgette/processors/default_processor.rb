module Courgette
  module Processors
    class DefaultProcessor < Processor
      def process(text)
        text.unpack('C*').pack('U*').gsub("\r\n", "\n")
      end
    end
  end
end
