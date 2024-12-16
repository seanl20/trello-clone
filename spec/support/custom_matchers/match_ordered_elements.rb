class MatchOrderedElements < RSpec::Matchers::BuiltIn::Eq
end

def match_ordered_elements(*expected_items)
  MatchOrderedElements.new(expected_items)
end
