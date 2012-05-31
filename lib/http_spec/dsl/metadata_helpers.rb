module HTTPSpec
  module DSL
    module MetadataHelpers
      def copy_superclass_metadata(key)
        return unless superclass_metadata && superclass_metadata[key]
        if superclass_metadata[key].equal?(metadata[key])
          metadata[key] = superclass_metadata[key].dup
        end
      end
    end
  end
end
