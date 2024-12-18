module Items
  module Changesets
    class Create
      def self.map(tuple)
        tuple.select { |attr| Item.attribute_names.include?(attr.to_s) }
      end
    end
  end
end
