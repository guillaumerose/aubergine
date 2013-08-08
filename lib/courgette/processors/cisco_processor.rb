module Courgette
  module Processors
    class CiscoProcessor < Processor
      def process(text)
        text.gsub(/^ntp clock-period \d+$/, "# ntp clock-period <hidden>")
      end
    end
  end
end
